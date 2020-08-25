import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    //final id = routeArgs['id'];
    final title = routeArgs['title'];
    final price = routeArgs['price'];
    final priceDescription = routeArgs['priceDescription'];
    final imageUrl = routeArgs['imageUrl'];
    final color = routeArgs['color'];

    return Scaffold(
      backgroundColor: color,
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 48.0,
              ),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 45,
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.07,
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
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
                        )),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Hero(
                  tag: title,
                  child: Image.asset(
                    imageUrl,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: isArabic(context)
                        ? Radius.circular(300)
                        : Radius.circular(0),
                    topRight: isArabic(context)
                        ? Radius.circular(0)
                        : Radius.circular(300),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.09,
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.033,
                            child: FittedBox(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.025,
                        child: Text(
                          priceDescription,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.033,
                            child: FittedBox(
                              child: Text(
                                isArabic(context)
                                    ? price.toString() + ' ريال'
                                    : price.toString() + ' SR',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 48,
                                  height: (MediaQuery.of(context).size.height -
                                          MediaQuery.of(context).padding.top) *
                                      0.074,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: isArabic(context)
                                          ? Radius.circular(0)
                                          : Radius.circular(15),
                                      bottomLeft: isArabic(context)
                                          ? Radius.circular(0)
                                          : Radius.circular(15),
                                      topRight: isArabic(context)
                                          ? Radius.circular(15)
                                          : Radius.circular(0),
                                      bottomRight: isArabic(context)
                                          ? Radius.circular(15)
                                          : Radius.circular(0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  )),
                              Container(
                                color: Colors.grey[300],
                                width: 48,
                                height: (MediaQuery.of(context).size.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.074,
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 48,
                                  height: (MediaQuery.of(context).size.height -
                                          MediaQuery.of(context).padding.top) *
                                      0.074,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: isArabic(context)
                                          ? Radius.circular(15)
                                          : Radius.circular(0),
                                      bottomLeft: isArabic(context)
                                          ? Radius.circular(15)
                                          : Radius.circular(0),
                                      topRight: isArabic(context)
                                          ? Radius.circular(0)
                                          : Radius.circular(15),
                                      bottomRight: isArabic(context)
                                          ? Radius.circular(0)
                                          : Radius.circular(15),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.03,
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            0.117975,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: color,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: color,
                                size: 36,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                height: 72,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    getTranslated(context, 'addToCart'),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
