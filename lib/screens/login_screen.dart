import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';
// import '../services/database.dart';
import '../localization/demo_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    return Scaffold(
      key: _key,
      body: new InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        width: (width) * 0.20,
                        height: (height) * 0.07,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/adminTabsScreen');
                          },
                          child: Text('Admin'),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                    ],
                  ),
                  Container(
                    width: width * 0.8,
                    height: height * 0.55,
                    child: Image.asset('assets/images/login.png'),
                  ),
                  Container(
                      width: width * 0.9,
                      height: height * 0.08,
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration:
                            InputDecoration(hintText: '+966 xx xxx xxxx'),
                        onChanged: (val) {
                          setState(() {
                            this.phoneNo = val;
                          });
                        },
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  codeSent
                      ? Column(
                          children: <Widget>[
                            Container(
                                width: width * 0.9,
                                height: height * 0.08,
                                padding:
                                    EdgeInsets.only(left: 25.0, right: 25.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: getTranslated(context, 'otp')),
                                  onChanged: (val) {
                                    setState(() {
                                      this.smsCode = val;
                                    });
                                  },
                                )),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    height: (height) * 0.1,
                    width: (width) * 0.9,
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: FloatingActionButton.extended(
                        label: codeSent
                            ? Text(getTranslated(context, 'login'))
                            : Text(getTranslated(context, 'verify')),
                        onPressed: () {
                          codeSent
                              ? Auth().signInWithOTP(
                                  smsCode, verificationId, phoneNo)
                              : verifyPhone(phoneNo);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      Auth().signIn(authResult, phoneNo);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
