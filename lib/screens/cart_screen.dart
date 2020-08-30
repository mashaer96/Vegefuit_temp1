import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import 'package:vegefruit/models/is_arabic.dart';
import 'package:vegefruit/widgets/hedear.dart';
import 'package:vegefruit/widgets/list_item.dart';

class CartScreen extends StatefulWidget {
  //final routeArgs = [{'title': 'WaterMelone', 'price': 2.45, 'priceDescription': 'Per unit', 'imageUrl': 'assets/images/watermelon.png', 'color': Color(0xFFFF3B4A),},{'title': 'WaterMelone', 'price': 2.45, 'priceDescription': 'Per unit', 'imageUrl': 'assets/images/watermelon.png', 'color': Color(0xFFFF3B4A),} ];
  // ModalRoute.of(context).settings.arguments as Map<String, Object>;
  //final id = routeArgs['id'];
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final id = 'p4';
  final title = 'Watermelone';
  final price = 2.45;
  final priceDescription = 'Per unit';
  final imageUrl = 'assets/images/watermelon.png';
  final color = Color(0xFFFF3B4A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Container(
        width: (MediaQuery.of(context).size.width) * 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header('shoppingCart'),
            Container(
              child: Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  itemCount: 8,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/productDetails',
                            arguments: {
                              'id': id,
                              'title': title,
                              'price': price,
                              'priceDescription': priceDescription,
                              'imageUrl': imageUrl,
                              'color': color,
                            });
                      },
                      child: ListItem(
                          title: title,
                          price: price,
                          color: color,
                          imageUrl: imageUrl),
                    );
                  },
                ),
              ),
            ),
            Container(
                width: (MediaQuery.of(context).size.width) * 1,
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.15,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //width: (MediaQuery.of(context).size.width) * 0.3,
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                          child: FittedBox(
                            child: Text(
                              getTranslated(context, 'total') + ':',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.width) * 0.02,
                        ),
                        Container(
                          //width: (MediaQuery.of(context).size.width) * 0.1,
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.04,
                          child: Text(
                            isArabic(context)
                                ? price.toString() + ' ريال'
                                : price.toString() + ' SR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width) * 0.5,
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) *
                          0.1,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(
                          color: Theme.of(context).canvasColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          getTranslated(context, 'orderNow'),
                          style: TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
