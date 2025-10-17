import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatelessWidget {
  final NativeAd nativeAd;
  
  const NativeAdWidget({super.key, required this.nativeAd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(16),
      child: AdWidget(ad: nativeAd),
    );
  }
}