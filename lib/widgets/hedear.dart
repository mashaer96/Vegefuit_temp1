import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
import '../screens/user_tabs_screen.dart';

class Header extends StatelessWidget {
  final String title;
  const Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 20.0,
        top: 45.0,
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.canPop(context)
                  ? Navigator.pop(context)
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => TabsScreen(),
                      ),
                    );
            },
            child: Container(
              width: 45,
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.07,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Icon(
                isArabic(context)
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.13,
          ),
          Text(
            getTranslated(context, title),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
