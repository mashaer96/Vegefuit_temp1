import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/user_tabs_screen.dart';
import '../screens/login_screen.dart';
import '../models/user.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserAuth _user = Provider.of<UserAuth>(context);

    return (_user != null)
        ? TabsScreen()
        : LoginScreen();
  }
}
