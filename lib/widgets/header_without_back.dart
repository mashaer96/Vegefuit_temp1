import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';

class HeaderWithoutBack extends StatelessWidget {
  final String title;
  const HeaderWithoutBack(this.title);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
    return Material(
      elevation: 10,
      child: Container(
        height: (height) * 0.14,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 14.0,
            top: 28.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  getTranslated(context, title),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
