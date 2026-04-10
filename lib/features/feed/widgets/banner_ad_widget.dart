import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:odiya_news_app/core/ads/ad_unit_ids.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  static const int _maxRetryAttempts = 3;
  static const Duration _defaultRetryDelay = Duration(seconds: 15);
  static const Duration _throttledRetryDelay = Duration(seconds: 45);
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isLoading = false;
  int _retryAttempts = 0;
  DateTime? _nextRetryAt;
  static const _bannerSize = AdSize.banner;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (_isLoading) {
      return;
    }

    final adUnitId = AdUnitIds.banner;
    if (adUnitId.isEmpty) {
      debugPrint('[Ads][Banner] Ad unit ID is missing from .env');
      return;
    }

    final now = DateTime.now();
    if (_nextRetryAt != null && now.isBefore(_nextRetryAt!)) {
      final delay = _nextRetryAt!.difference(now);
      debugPrint(
        '[Ads][Banner] Deferring load for ${delay.inSeconds}s due to cooldown.',
      );
      _scheduleRetry(delay);
      return;
    }

    _bannerAd?.dispose();
    _bannerAd = null;
    _isLoading = true;
    _isLoaded = false;
    debugPrint(
      '[Ads][Banner] Starting load. attempt=${_retryAttempts + 1} unit=${AdUnitIds.banner}',
    );

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: _bannerSize,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('[Ads][Banner] Loaded successfully.');
          _isLoading = false;
          _retryAttempts = 0;
          _nextRetryAt = null;
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint(
            '[Ads][Banner] Failed to load. code=${error.code} message=${error.message}',
          );
          ad.dispose();
          _bannerAd = null;
          _isLoading = false;
          if (!mounted) {
            return;
          }

          setState(() {
            _isLoaded = false;
          });

          if (_retryAttempts >= _maxRetryAttempts) {
            debugPrint(
              '[Ads][Banner] Retry limit reached for this widget lifecycle.',
            );
            return;
          }

          _retryAttempts += 1;
          final delay = _retryDelayFor(error);
          _nextRetryAt = DateTime.now().add(delay);
          debugPrint(
            '[Ads][Banner] Scheduling retry in ${delay.inSeconds}s.'
            ' retry=$_retryAttempts/$_maxRetryAttempts',
          );
          _scheduleRetry(delay);
        },
      ),
    );

    _bannerAd?.load();
  }

  Duration _retryDelayFor(LoadAdError error) {
    if (error.code == 1) {
      final multiplier = _retryAttempts.clamp(1, _maxRetryAttempts);
      return Duration(seconds: _throttledRetryDelay.inSeconds * multiplier);
    }
    return _defaultRetryDelay;
  }

  void _scheduleRetry(Duration delay) {
    Future.delayed(delay, () {
      if (!mounted || _isLoaded || _isLoading) {
        return;
      }
      _loadAd();
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerSize.width.toDouble(),
      height: _bannerSize.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
