import 'package:flutter/material.dart';

import '../widgets/hedear_with_back.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithBack('favorites'),
          ],
        ),
      ),
    );
  }
}
