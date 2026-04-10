import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdUnitIds {
  AdUnitIds._();

  static String get banner {
    return dotenv.env['ADMOB_BANNER_AD_UNIT_ID'] ?? '';
  }

  static String get interstitial {
    return dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID'] ?? '';
  }

  static void logResolvedConfig() {
    if (!kDebugMode) {
      return;
    }

    debugPrint(
      '[Ads] Config loaded.'
      ' banner=${_maskAdUnitId(banner)}'
      ' interstitial=${_maskAdUnitId(interstitial)}',
    );
  }

  static String _maskAdUnitId(String value) {
    if (value.isEmpty) {
      return '<missing>';
    }

    final parts = value.split('/');
    if (parts.length != 2) {
      return value;
    }

    final account = parts.first;
    final slot = parts.last;
    final maskedAccount = account.length <= 8
        ? account
        : '${account.substring(0, 8)}...';
    final maskedSlot = slot.length <= 4
        ? slot
        : '...${slot.substring(slot.length - 4)}';
    return '$maskedAccount/$maskedSlot';
  }
}
