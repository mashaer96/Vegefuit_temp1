import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
