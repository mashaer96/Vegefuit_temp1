import 'package:flutter/material.dart';
import 'package:vegefruit/localization/demo_localization.dart';
// import 'package:vegefruit/models/is_arabic.dart';

class EmptyStatus extends StatelessWidget {
  final String message;

  EmptyStatus({this.message});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;

    return Container(
      width: (MediaQuery.of(context).size.width) * 0.6,
      margin: EdgeInsets.only(top: 120),
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/empty-states.png'),
          SizedBox(height: height * 0.04),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            getTranslated(context, 'emptyState'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffacb6be),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
