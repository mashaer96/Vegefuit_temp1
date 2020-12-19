import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
//import '../screens/user_tabs_screen.dart';

class HeaderWithBack extends StatelessWidget {
  final String title;
  const HeaderWithBack(this.title);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
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
              // Navigator.canPop(context)
              //     ? Navigator.pop(context)
              //     : Navigator.pushReplacement(
              //         context,
              //         // MaterialPageRoute(
              //           // builder: (BuildContext context) => TabsScreen(),
              //         // ),
              //       );
            },
            child: Container(
              width: (width) * 0.12,
              height: (height) * 0.07,
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
            width: (width) * 0.19,
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
