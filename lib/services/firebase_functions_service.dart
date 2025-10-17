import 'package:cloud_functions/cloud_functions.dart';

class FirebaseFunctionsService {
  static FirebaseFunctionsService get instance => _instance;
  static final FirebaseFunctionsService _instance = FirebaseFunctionsService._internal();
  factory FirebaseFunctionsService() => _instance;
  // FirebaseFunctionsService._internal();

  // Singleton Firebase Functions instance
  final FirebaseFunctions _functions = FirebaseFunctions.instanceFor(region: 'asia-south1');

  FirebaseFunctionsService._internal() {
    // _functions.useFunctionsEmulator("192.168.29.107", 5001);
  }

  // Getter to access the Firebase Functions instance
  FirebaseFunctions get functions => _functions;
}
