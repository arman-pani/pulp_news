import 'dart:io';

/// Returns [true] when the device can reach the internet by performing a
/// real DNS lookup. Falls back to [false] on any error or timeout.
Future<bool> hasNetworkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com').timeout(
      const Duration(seconds: 5),
    );
    return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}
