import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'monetization_config.dart';

enum PurchaseResult { success, cancelled, pending, failed, unavailable }

/// Real-money store. Granting is delegated to [onGrant] (wired to
/// MonetizationService), called once per delivered order.
abstract class StoreService extends ChangeNotifier {
  bool get available;

  /// Localized price from the store, or null while unknown.
  String? price(ProductKind p);

  /// [orderId] identifies the order so a re-delivered purchase pays once.
  void Function(ProductKind product, String orderId)? onGrant;

  Future<void> init();
  Future<PurchaseResult> buy(ProductKind p);
  Future<void> restore();
}

class DisabledStoreService extends StoreService {
  @override
  bool get available => false;
  @override
  String? price(ProductKind p) => null;
  @override
  Future<void> init() async {}
  @override
  Future<PurchaseResult> buy(ProductKind p) async => PurchaseResult.unavailable;
  @override
  Future<void> restore() async {}
}

/// Stand-in store for tests and TEST builds before the products exist in
/// Play Console: purchases succeed instantly and nothing is charged.
class FakeStoreService extends StoreService {
  static const _prices = {
    ProductKind.coinsSmall: '₺29,99',
    ProductKind.coinsMedium: '₺59,99',
    ProductKind.coinsLarge: '₺119,99',
    ProductKind.starterPack: '₺39,99',
    ProductKind.noAds: '₺89,99',
  };
  int _orders = 0;

  @override
  bool get available => true;
  @override
  String? price(ProductKind p) => '${_prices[p]}\n(test)';
  @override
  Future<void> init() async {}
  @override
  Future<PurchaseResult> buy(ProductKind p) async {
    onGrant?.call(p, 'fake-${DateTime.now().microsecondsSinceEpoch}-${_orders++}');
    return PurchaseResult.success;
  }

  @override
  Future<void> restore() async {}
}

/// Google Play Billing / App Store via the in_app_purchase plugin.
class PlatformStoreService extends StoreService {
  final _iap = InAppPurchase.instance;
  final Map<ProductKind, ProductDetails> _products = {};
  final Map<String, Completer<PurchaseResult>> _waiting = {};
  StreamSubscription<List<PurchaseDetails>>? _sub;
  bool _available = false;

  @override
  bool get available => _available && _products.isNotEmpty;

  @override
  String? price(ProductKind p) => _products[p]?.price;

  @override
  Future<void> init() async {
    _available = await _iap.isAvailable();
    if (!_available) return;
    _sub = _iap.purchaseStream.listen(_onPurchases, onError: (Object e) => debugPrint('Store error: $e'));
    final r = await _iap.queryProductDetails({for (final p in ProductKind.values) p.id});
    for (final d in r.productDetails) {
      final kind = ProductKind.byId(d.id);
      if (kind != null) _products[kind] = d;
    }
    if (r.notFoundIDs.isNotEmpty) debugPrint('Store products not found: ${r.notFoundIDs}');
    notifyListeners();
  }

  @override
  Future<PurchaseResult> buy(ProductKind p) async {
    final details = _products[p];
    if (details == null) return PurchaseResult.unavailable;
    final waiting = _waiting[p.id] = Completer<PurchaseResult>();
    final param = PurchaseParam(productDetails: details);
    try {
      final started = p.oneTime ? await _iap.buyNonConsumable(purchaseParam: param) : await _iap.buyConsumable(purchaseParam: param);
      if (!started) return _finish(p.id, PurchaseResult.failed);
    } catch (e) {
      debugPrint('Purchase failed to start: $e');
      return _finish(p.id, PurchaseResult.failed);
    }
    return waiting.future;
  }

  PurchaseResult _finish(String id, PurchaseResult r) {
    final c = _waiting.remove(id);
    if (c != null && !c.isCompleted) c.complete(r);
    return r;
  }

  Future<void> _onPurchases(List<PurchaseDetails> list) async {
    for (final pd in list) {
      final kind = ProductKind.byId(pd.productID);
      switch (pd.status) {
        case PurchaseStatus.pending:
          _finish(pd.productID, PurchaseResult.pending);
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // Restores only bring back one-time products.
          if (kind != null && (pd.status == PurchaseStatus.purchased || kind.oneTime)) {
            onGrant?.call(kind, pd.purchaseID ?? '${pd.productID}-${pd.transactionDate}');
          }
          _finish(pd.productID, PurchaseResult.success);
        case PurchaseStatus.canceled:
          _finish(pd.productID, PurchaseResult.cancelled);
        case PurchaseStatus.error:
          debugPrint('Purchase error: ${pd.error}');
          _finish(pd.productID, PurchaseResult.failed);
      }
      if (pd.pendingCompletePurchase) await _iap.completePurchase(pd);
    }
    notifyListeners();
  }

  @override
  Future<void> restore() => _iap.restorePurchases();

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

/// TEST builds: the real store when its products load, otherwise the fake
/// store, so the purchase flow can be tried before Play Console is set up.
class DebugFallbackStoreService extends StoreService {
  final _real = PlatformStoreService();
  final _fake = FakeStoreService();
  StoreService get _active => _real.available ? _real : _fake;

  DebugFallbackStoreService() {
    _real.addListener(notifyListeners);
  }

  @override
  set onGrant(void Function(ProductKind product, String orderId)? f) {
    super.onGrant = f;
    _real.onGrant = f;
    _fake.onGrant = f;
  }

  @override
  bool get available => true;
  @override
  String? price(ProductKind p) => _active.price(p);
  @override
  Future<void> init() async {
    try {
      await _real.init();
    } catch (e) {
      debugPrint('Real store unavailable, using the test store: $e');
    }
    notifyListeners();
  }

  @override
  Future<PurchaseResult> buy(ProductKind p) => _active.buy(p);
  @override
  Future<void> restore() => _active.restore();
}
