import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'cart').toString(),
        ),
      ),
      body: Center(child: (Text('This is the favorites screen'))),
    );
  }
}
