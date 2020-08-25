import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'profile').toString(),
        ),
      ),
      body: Center(child: (Text('This is the favorites screen'))),
    );
  }
}
