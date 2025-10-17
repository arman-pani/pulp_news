import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHandler {
  static Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        debugPrint("Signed in with UID: ${user.uid}");
      }
    } catch (e) {
      debugPrint("Error during anonymous sign-in: $e");
    }
  }
}
