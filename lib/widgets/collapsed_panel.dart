import 'package:flutter/material.dart';
import '../localization/demo_localization.dart';

Widget collapsedPanel(context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //first container
              height: 20,
              width: 60,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 0.002),
                child: RaisedButton(
                    color: Theme.of(context).canvasColor,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            ),
            Text(
              getTranslated(context, 'showAdded'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
