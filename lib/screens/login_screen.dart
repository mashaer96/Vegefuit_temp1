import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:vegefruit/localization/demo_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  // TextEditingController _phoneNumberController = TextEditingController();

  // TextEditingController _verifierController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // _login() async {
  //   try {
  //     auth.User _user = (await _firebaseAuth.signInWithPhoneNumber(
  //         _phoneNumberController.text.trim(),
  //         (_verifierController.text) as RecaptchaVerifier)) as auth.User;

  //     _key.currentState.showSnackBar((SnackBar(
  //         content: Text(getTranslated(context, 'successfullLogin')))));
  //   } catch (ex) {
  //     _key.currentState.showSnackBar(
  //         (SnackBar(content: Text((ex as PlatformException).message))));
  //   }
  // }

  @override
  void initState() {
   
    super.initState();

   auth.User currentUser = _firebaseAuth.currentUser;

      if(currentUser != null){
        Navigator.of(context).pushNamed('/adminTabsScreen');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text('This is the Log in Screen'),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed('/adminTabsScreen');
              },
              label: Text('Admin'),
              heroTag: '/adminTabsScreen',
              icon: Icon(Icons.arrow_right),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed('/tabScreen');
              },
              label: Text('User'),
              icon: Icon(Icons.arrow_right),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
