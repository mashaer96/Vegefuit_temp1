import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';
import '../services/auth.dart';

import '../widgets/hedear_with_back.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithBack("profile"),
            //logout
            Center(
              child: FloatingActionButton.extended(
                onPressed: () {
                  Auth().signOut();
                },
                label: Text(getTranslated(context, 'logout')),
                heroTag: '/loginScreen',
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/adminTabsScreen');
                          },
                          child: Text('Admin'),
                        ),
          ],
        ),
      ),
    );
  }
}
