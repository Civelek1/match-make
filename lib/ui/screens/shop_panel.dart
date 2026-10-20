import 'package:flutter/material.dart';

import '../../app/app_services.dart';
import '../../audio/audio_service.dart';
import '../../economy/economy_config.dart';
import '../../monetization/monetization_config.dart';
import '../../monetization/store_service.dart';
import '../theme/game_colors.dart';
import '../widgets/economy_widgets.dart';
import '../widgets/game_button.dart';
import '../widgets/game_panel.dart';
import '../widgets/game_text.dart';
import '../widgets/game_widgets.dart';

/// Booster shop: every booster with its price, owned count and a buy button.
Future<void> showShop(BuildContext context) {
  return showGameModal<void>(
    context,
    builder: (ctx) => Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Material(
          type: MaterialType.transparency,
          child: _ShopPanel(onClose: () => Navigator.of(ctx).pop()),
        ),
      ),
    ),
  );
}

/// Offers one booster the player has run out of. Resolves true if bought.
Future<bool> offerBooster(BuildContext context, BoosterKind kind) async {
  final r = await showGameModal<bool>(
    context,
    builder: (ctx) => Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          type: MaterialType.transparency,
          child: _OfferPanel(kind: kind),
        ),
      ),
    ),
  );
  return r ?? false;
}

/// Attempts a purchase with feedback (sound, toast). Returns success.
bool _buy(BuildContext context, BoosterKind kind) {
  final s = context.services;
  if (s.economy.buy(kind)) {
    s.audio.play(Sfx.unlock);
    s.haptics.success();
    showGameToast(context, s.loc.t('shop.bought', {'name': s.loc.t(kind.nameKey)}), icon: Icons.check_circle_rounded);
    return true;
  }
  s.audio.play(Sfx.locked);
  s.haptics.error();
  showGameToast(context, s.loc.t('shop.not_enough'), message: s.loc.t('shop.not_enough_msg'), icon: Icons.info_rounded);
  return false;
}

class _ShopPanel extends StatelessWidget {
  final VoidCallback onClose;
  const _ShopPanel({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    return ListenableBuilder(
      listenable: Listenable.merge([s.economy, s.monetization]),
      builder: (context, _) => GamePanel(
        title: loc.t('shop.title'),
        ribbon: GameColors.green,
        onClose: onClose,
        maxWidth: 440,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(color: GameColors.ink, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CoinIcon(size: 26),
                        const SizedBox(width: 6),
                        GameText('${s.economy.coins}', size: 20, strokeWidth: 0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (s.monetization.adRewardsAvailable) ...[
                  _section(loc.t('shop.free')),
                  const _AdCoinsRow(),
                  const SizedBox(height: 8),
                ],
                if (s.monetization.shop.available) ...[
                  _section(loc.t('shop.specials')),
                  for (final p in [ProductKind.starterPack, ProductKind.noAds])
                    if (!s.monetization.owns(p)) _ProductRow(product: p),
                  _section(loc.t('shop.packs')),
                  for (final p in ProductKind.coinPacks) _ProductRow(product: p),
                  const SizedBox(height: 8),
                ],
                _section(loc.t('shop.in_level')),
                for (final b in BoosterKind.inLevel) _ShopRow(kind: b),
                const SizedBox(height: 8),
                _section(loc.t('shop.start')),
                for (final b in BoosterKind.start) _ShopRow(kind: b),
                if (s.monetization.shop.available)
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        await s.monetization.restore();
                        if (context.mounted) showGameToast(context, loc.t('shop.restored'), icon: Icons.restore_rounded);
                      },
                      child: Text(
                        loc.t('shop.restore'),
                        style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.inkSoft, fontSize: 13),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 2),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.inkSoft, letterSpacing: 1.5, fontSize: 12),
    ),
  );
}

class _ShopRow extends StatelessWidget {
  final BoosterKind kind;
  const _ShopRow({required this.kind});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final unlocked = s.economy.isUnlocked(kind);
    final affordable = s.economy.coins >= kind.price;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : GameColors.creamDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GameColors.creamDark, width: 2),
      ),
      child: Row(
        children: [
          Opacity(opacity: unlocked ? 1 : 0.45, child: BoosterIcon(kind, size: 46)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.t(kind.nameKey),
                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 15),
                ),
                Text(
                  unlocked ? loc.t(kind.howKey) : loc.t('shop.locked', {'n': kind.unlockLevel}),
                  style: const TextStyle(fontWeight: FontWeight.w600, color: GameColors.inkSoft, fontSize: 11.5, height: 1.25),
                ),
                if (unlocked)
                  Text(
                    loc.t('shop.owned', {'n': s.economy.count(kind)}),
                    style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.purpleDark, fontSize: 12),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (unlocked)
            _PriceButton(price: kind.price, enabled: affordable, onTap: () => _buy(context, kind))
          else
            const Icon(Icons.lock_rounded, color: GameColors.greyDark, size: 28),
        ],
      ),
    );
  }
}

/// Green button showing a coin price.
class _PriceButton extends StatelessWidget {
  final int price;
  final bool enabled;
  final VoidCallback onTap;
  const _PriceButton({required this.price, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${context.services.loc.t('shop.buy')} $price',
      excludeSemantics: true,
      child: Pressable(
        onTap: onTap,
        child: Opacity(
          opacity: enabled ? 1 : 0.6,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF8BE36F), GameColors.green],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: GameColors.greenDark, width: 2.5),
              boxShadow: const [BoxShadow(color: GameColors.greenDark, offset: Offset(0, 3))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CoinIcon(size: 22),
                const SizedBox(width: 4),
                GameText('$price', size: 16, strokeWidth: 3, stroke: GameColors.greenDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OfferPanel extends StatelessWidget {
  final BoosterKind kind;
  const _OfferPanel({required this.kind});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    return ListenableBuilder(
      listenable: s.economy,
      builder: (context, _) => GamePanel(
        title: loc.t(kind.nameKey),
        ribbon: BoosterIcon.colorOf(kind),
        onClose: () => Navigator.of(context).pop(false),
        maxWidth: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BoosterIcon(kind, size: 72),
            const SizedBox(height: 10),
            BodyText(loc.t(kind.howKey), size: 15),
            const SizedBox(height: 6),
            Text(
              loc.t('booster.none'),
              style: const TextStyle(fontWeight: FontWeight.w800, color: GameColors.redDark, fontSize: 13),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CoinIcon(size: 22),
                const SizedBox(width: 4),
                Text(
                  '${s.economy.coins}',
                  style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GameButton.secondary(
              label: '${loc.t('shop.buy')}  ${kind.price}',
              icon: Icons.shopping_basket_rounded,
              tone: ButtonTone.green,
              width: double.infinity,
              onTap: () {
                if (_buy(context, kind)) Navigator.of(context).pop(true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Card frame shared by the free-coins and store rows.
Widget _card({required Widget leading, required String title, required String subtitle, required Widget action}) => Container(
  margin: const EdgeInsets.only(bottom: 8),
  padding: const EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: GameColors.creamDark, width: 2),
  ),
  child: Row(
    children: [
      SizedBox(width: 46, height: 46, child: Center(child: leading)),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: GameColors.ink, fontSize: 15)),
            Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.w600, color: GameColors.inkSoft, fontSize: 11.5, height: 1.25),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      action,
    ],
  ),
);

/// Watch a rewarded ad for coins (a few times a day).
class _AdCoinsRow extends StatelessWidget {
  const _AdCoinsRow();

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final m = s.monetization;
    final left = m.adCoinsLeft;
    return _card(
      leading: Icon(m.noAds ? Icons.card_giftcard_rounded : Icons.smart_display_rounded, color: GameColors.purple, size: 40),
      title: loc.t(m.noAds ? 'shop.ad_coins_vip' : 'shop.ad_coins', {'n': AdRewards.coins}),
      subtitle: left > 0 ? loc.t('shop.ad_left', {'n': left}) : loc.t('shop.ad_done'),
      action: _MoneyButton(
        label: m.noAds ? loc.t('shop.buy') : loc.t('shop.ad_watch'),
        enabled: left > 0,
        onTap: () async {
          if (await m.claimAdCoins()) {
            s.audio.play(Sfx.unlock);
            s.haptics.success();
            if (context.mounted) {
              showGameToast(context, '+${AdRewards.coins} ${loc.t('shop.coins')}', icon: Icons.check_circle_rounded);
            }
          } else if (left > 0 && context.mounted) {
            showGameToast(context, loc.t('ad.unavailable'));
          }
        },
      ),
    );
  }
}

/// A real-money product with its store price.
class _ProductRow extends StatelessWidget {
  final ProductKind product;
  const _ProductRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final s = context.services;
    final loc = s.loc;
    final m = s.monetization;
    final price = m.shop.price(product);
    final owned = product.oneTime && m.owns(product);
    final subtitle = loc.t('${product.nameKey}.how');
    return _card(
      leading: product == ProductKind.noAds
          ? const Icon(Icons.block_rounded, color: GameColors.red, size: 40)
          : product == ProductKind.starterPack
          ? const Icon(Icons.card_giftcard_rounded, color: GameColors.orange, size: 40)
          : CoinIcon(size: 26 + 6.0 * ProductKind.coinPacks.indexOf(product)),
      title: loc.t(product.nameKey),
      subtitle: subtitle,
      action: _MoneyButton(
        label: owned ? loc.t('shop.owned_once') : (price ?? '…'),
        enabled: !owned && price != null,
        onTap: () => _buyProduct(context, product),
      ),
    );
  }
}

Future<void> _buyProduct(BuildContext context, ProductKind p) async {
  final s = context.services;
  final loc = s.loc;
  final r = await s.monetization.buy(p);
  if (!context.mounted) return;
  switch (r) {
    case PurchaseResult.success:
      s.audio.play(Sfx.galleryUnlock);
      s.haptics.success();
      showGameToast(context, loc.t('shop.purchase_ok', {'name': loc.t(p.nameKey)}), icon: Icons.check_circle_rounded);
    case PurchaseResult.pending:
      showGameToast(context, loc.t('shop.purchase_pending'), icon: Icons.hourglass_top_rounded);
    case PurchaseResult.cancelled:
      break;
    case PurchaseResult.unavailable:
      showGameToast(context, loc.t('shop.store_unavailable'));
    case PurchaseResult.failed:
      showGameToast(context, loc.t('shop.purchase_failed'));
  }
}

/// Green button with a text label (store price or action).
class _MoneyButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  const _MoneyButton({required this.label, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Pressable(
        onTap: enabled ? onTap : null,
        child: Opacity(
          opacity: enabled ? 1 : 0.55,
          child: Container(
            constraints: const BoxConstraints(minWidth: 72),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF8BE36F), GameColors.green],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: GameColors.greenDark, width: 2.5),
              boxShadow: const [BoxShadow(color: GameColors.greenDark, offset: Offset(0, 3))],
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 13.5),
            ),
          ),
        ),
      ),
    );
  }
}
