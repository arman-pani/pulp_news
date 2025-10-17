import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _user = Rx<User?>(null);
  
  User? get user => _user.value;
  bool get isSignedIn => _user.value != null;
  
  @override
  void onInit() {
    super.onInit();
    _user.value = _auth.currentUser;
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user.value = user;
      debugPrint('Auth state changed: ${user?.uid ?? 'No user'}');
    });
  }
  
  Future<void> signInAnonymously() async {
    try {
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
        debugPrint('Signed in anonymously: ${_auth.currentUser?.uid}');
      }
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      rethrow;
    }
  }
  
  Future<String?> getIdToken() async {
    try {
      if (_auth.currentUser != null) {
        return await _auth.currentUser!.getIdToken();
      }
      return null;
    } catch (e) {
      debugPrint('Error getting ID token: $e');
      return null;
    }
  }
  
  Future<String?> getFreshIdToken() async {
    try {
      if (_auth.currentUser != null) {
        return await _auth.currentUser!.getIdToken(true);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting fresh ID token: $e');
      return null;
    }
  }
  
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint('Signed out');
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }
}
