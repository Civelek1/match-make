import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'monetization_config.dart';

/// Rewarded ads. Every call is safe to make at any time: when ads can't be
/// shown (no consent, offline, web) [available] is false and
/// [showRewarded] resolves false, and the UI hides ad buttons.
abstract class AdsService extends ChangeNotifier {
  /// A rewarded ad is loaded (or loading) and may be shown.
  bool get available;

  /// The player must be able to reopen the consent form (EEA/UK).
  bool get privacyOptionsRequired;

  Future<void> init();

  /// Shows a rewarded ad; true when the player earned the reward.
  Future<bool> showRewarded(AdPlacement placement);

  Future<void> showPrivacyOptions();
}

class DisabledAdsService extends AdsService {
  @override
  bool get available => false;
  @override
  bool get privacyOptionsRequired => false;
  @override
  Future<void> init() async {}
  @override
  Future<bool> showRewarded(AdPlacement placement) async => false;
  @override
  Future<void> showPrivacyOptions() async {}
}

/// Google AdMob with the User Messaging Platform consent flow.
class AdMobAdsService extends AdsService {
  RewardedAd? _ad;
  bool _loading = false;
  bool _ready = false;
  bool _privacyRequired = false;
  int _failures = 0;

  @override
  bool get available => _ready && (_ad != null || _loading);

  @override
  bool get privacyOptionsRequired => _privacyRequired;

  @override
  Future<void> init() async {
    // Ask for consent where the law requires it (EEA, UK, Switzerland), then
    // start the SDK only if ads may be requested.
    final consent = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () => ConsentForm.loadAndShowConsentFormIfRequired((_) => consent.complete()),
      (_) => consent.complete(),
    );
    await consent.future;
    _privacyRequired =
        await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() == PrivacyOptionsRequirementStatus.required;
    if (!await ConsentInformation.instance.canRequestAds()) {
      notifyListeners();
      return;
    }
    await MobileAds.instance.initialize();
    await MobileAds.instance.updateRequestConfiguration(RequestConfiguration(maxAdContentRating: MaxAdContentRating.pg));
    _ready = true;
    _load();
  }

  void _load() {
    if (!_ready || _loading || _ad != null) return;
    _loading = true;
    notifyListeners();
    RewardedAd.load(
      adUnitId: AdIds.rewarded,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = false;
          _failures = 0;
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded ad failed to load: $error');
          _loading = false;
          _failures++;
          notifyListeners();
          // Back off (offline, no fill): 10 s, 20 s, 40 s… up to 5 minutes.
          Timer(Duration(seconds: (10 * (1 << (_failures - 1).clamp(0, 5))).clamp(10, 300)), _load);
        },
      ),
    );
  }

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    if (_ad == null && _loading) {
      // Give a loading ad a few seconds before giving up.
      for (var i = 0; i < 20 && _ad == null && _loading; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 250));
      }
    }
    final ad = _ad;
    if (ad == null) {
      _load();
      return false;
    }
    _ad = null;
    var earned = false;
    final done = Completer<bool>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!done.isCompleted) done.complete(earned);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('Rewarded ad failed to show: $error');
        ad.dispose();
        if (!done.isCompleted) done.complete(false);
      },
    );
    await ad.show(onUserEarnedReward: (_, _) => earned = true);
    final result = await done.future;
    _load();
    return result;
  }

  @override
  Future<void> showPrivacyOptions() async {
    final done = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((_) => done.complete());
    await done.future;
    if (!_ready && await ConsentInformation.instance.canRequestAds()) {
      await MobileAds.instance.initialize();
      _ready = true;
      _load();
    }
  }
}
