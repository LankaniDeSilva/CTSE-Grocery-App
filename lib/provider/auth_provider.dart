import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/services/auth_services.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  //-----------Auth controller instance
  final _authenticationService = AuthenticationService();

  //-----------save firebase user
  User? _firebaseUser;

  //------google auth
  Future<void> googleAuth() async {
    try {
      final userCredetial = await _authenticationService.signInWithGoogle();
      if (userCredetial != null) {
        Logger().w(userCredetial.user);
        //---------setting create firebase user details
        _firebaseUser = userCredetial.user;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
