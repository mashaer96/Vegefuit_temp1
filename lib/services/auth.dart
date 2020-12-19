import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';
import '../screens/user_tabs_screen.dart';
import '../screens/login_screen.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  StreamBuilder handleAuth() {
    return StreamBuilder(
        // ignore: deprecated_member_use
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return TabsScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  //Sign out
  Future<void> signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  //SignIn
  Future<void> signIn(AuthCredential authCreds, String phoneNo) async {
    try {
      await _auth.signInWithCredential(authCreds);
    } catch (e) {
      print(e);
    }
    Database().userSetup(phoneNo);
  }

  Future<void> signInWithOTP(smsCode, verId, String phoneNo) async {
    try {
      AuthCredential authCreds =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      await signIn(authCreds, phoneNo);
    } catch (e) {
      print(e);
    }
  }
}
