import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserAuth> get user {
    // ignore: deprecated_member_use
    return _auth.onAuthStateChanged.map(
      (User firebaseUser) =>
          (firebaseUser != null) ? UserAuth(uid: firebaseUser.uid) : null,
    );
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
  Future<void> signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithOTP(smsCode, verId) async {
    try {
      AuthCredential authCreds =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      await signIn(authCreds);
    } catch (e) {
      print(e);
    }
  }
}
