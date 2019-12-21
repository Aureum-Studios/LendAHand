import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser;

  AuthService() {}

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
        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        notifyListeners();
        return user;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelled by user');
        return null;
      case FacebookLoginStatus.error:
        print('authentication error');
        return null;
    }
    return null;
  }

  Future<FirebaseUser> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleAuth = GoogleSignIn(scopes: ['email']);
      final GoogleSignInAccount googleUser = await _googleAuth.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential =
          GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      notifyListeners();
      return user;
    } catch (exception) {
      print("Exception: " + exception.message);
      throw new AuthException(exception.code, exception.message);
    }
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      notifyListeners();
      return user;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }
}
