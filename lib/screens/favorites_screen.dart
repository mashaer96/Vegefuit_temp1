import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'favorites').toString(),
        ),
      ),
      body: Center(child: (Text('This is the favorites screen'))),
    );
  }
}
