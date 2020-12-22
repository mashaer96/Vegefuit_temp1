import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';
import '../services/auth.dart';

// import '../widgets/hedear_with_back.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            getTranslated(context, 'profile'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //logout
            Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Auth().signOut();
                  },
                  label: Text(getTranslated(context, 'logout')),
                  heroTag: '/loginScreen',
                  backgroundColor: Theme.of(context).primaryColor,
                ),
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
