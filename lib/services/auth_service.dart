import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser;

  AuthService() {
    print("new AuthService");
  }

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  Future<void> logout() async {
    var result = _auth.signOut();
    notifyListeners();
    return result;
  }

  Future createUser({String firstName, String lastName, String email, String password}) async {}

  Future<FirebaseUser> loginWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginStatus = await facebookLogin.logIn(['email']);

    switch (facebookLoginStatus.status) {
      case FacebookLoginStatus.loggedIn:
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: facebookLoginStatus.accessToken.token);
        var firebaseResult = await _auth.signInWithCredential(credential);
        notifyListeners();
        return firebaseResult.user;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelled by user');
        return null;
      case FacebookLoginStatus.error:
        print('authentication error');
        return null;
    }
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return result.user;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }
}
