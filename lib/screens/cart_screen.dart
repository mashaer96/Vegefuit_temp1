import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegefruit/models/product.dart';
import 'package:vegefruit/widgets/cart_item.dart';
import 'package:vegefruit/widgets/empty_status.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
import '../models/user.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();
  bool notAllowed = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height =
        mq.size.height - AppBar().preferredSize.height - mq.padding.top;
    final width = mq.size.width;
    final users = Provider.of<List<UserAuth>>(context);
    final allProducstList = Provider.of<List<Product>>(context);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            getTranslated(context, 'shoppingCart'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
      body: (users.where((user) => (user.uid == uid)).first.cart.length != 0)
          ? Container(
              width: (MediaQuery.of(context).size.width) * 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: (allProducstList != null)
                        ? Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                              ),
                              itemCount: users
                                  .where((user) => (user.uid == uid))
                                  .first
                                  .cart
                                  .keys
                                  .toList()
                                  .length,
                              itemBuilder: (ctx, i) {
                                String id = users
                                    .where((user) => (user.uid == uid))
                                    .first
                                    .cart
                                    .keys
                                    .toList()[i];
                                var quantity = users
                                    .where((user) => (user.uid == uid))
                                    .first
                                    .cart
                                    .values
                                    .toList()[i];
                                double price = allProducstList
                                    .where((p) => (p.id ==
                                        users
                                            .where((user) => (user.uid == uid))
                                            .first
                                            .cart
                                            .keys
                                            .toList()[i]))
                                    .first
                                    .price;
                                notAllowed = allProducstList
                                            .where((p) => (p.id == id))
                                            .first
                                            .quantity ==
                                        0.0
                                    ? true
                                    : false;
                                return CartItem(
                                    id: id,
                                    title: isArabic(context)
                                        ? allProducstList
                                            .where((p) => (p.id ==
                                                users
                                                    .where((user) =>
                                                        (user.uid == uid))
                                                    .first
                                                    .cart
                                                    .keys
                                                    .toList()[i]))
                                            .first
                                            .titleAr
                                        : allProducstList
                                            .where((p) => (p.id ==
                                                users
                                                    .where((user) =>
                                                        (user.uid == uid))
                                                    .first
                                                    .cart
                                                    .keys
                                                    .toList()[i]))
                                            .first
                                            .titleEn,
                                    price: price,
                                    quantity: quantity,
                                    color: allProducstList
                                        .where((p) => (p.id ==
                                            users
                                                .where(
                                                    (user) => (user.uid == uid))
                                                .first
                                                .cart
                                                .keys
                                                .toList()[i]))
                                        .first
                                        .color,
                                    imageUrl: allProducstList
                                        .where((p) => (p.id == users.where((user) => (user.uid == uid)).first.cart.keys.toList()[i]))
                                        .first
                                        .image);
                              },
                            ),
                          )
                        : Center(
                            child: Text(getTranslated(context, 'loading')),
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
                                height:
                                    (MediaQuery.of(context).size.width) * 0.02,
                              ),
                              Container(
                                //width: (MediaQuery.of(context).size.width) * 0.1,
                                height: (MediaQuery.of(context).size.height -
                                        MediaQuery.of(context).padding.top) *
                                    0.04,
                                child: Text(
                                  isArabic(context)
                                      ? _getTotal(users
                                              .where(
                                                  (user) => (user.uid == uid))
                                              .first
                                              .cart) +
                                          ' ريال'
                                      : _getTotal(users
                                              .where(
                                                  (user) => (user.uid == uid))
                                              .first
                                              .cart) +
                                          ' SR',
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
                            child: RaisedButton(
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
                              elevation: 0.0,
                              textColor: Colors.black,
                              color: Theme.of(context).primaryColor,
                              disabledTextColor: Colors.white,
                              disabledColor: Color(0xFF808080),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Theme.of(context).canvasColor,
                                      width: 2)),
                              onPressed: notAllowed ? null : () {},
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                EmptyStatus(message: getTranslated(context, 'emptyStock')),
                SizedBox(
                  height: height * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.4,
                      height: height * 0.08,
                      child: RaisedButton(
                          child: Text(
                            getTranslated(context, 'shopNow'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          textColor: Colors.black,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/tabScreen');
                          }),
                    ),
                  ],
                )
              ],
            ),
    );
  }

  String _getTotal(Map items) {
    final users = Provider.of<List<UserAuth>>(context);
    final allProducstList = Provider.of<List<Product>>(context);
    var total = 0.0;
    var quantity = [];
    items.forEach((key, value) => quantity.add(double.parse(value.toString())));

    for (int i = 0; i < quantity.length; i++) {
      total += (quantity[i] *
          allProducstList
              .where((p) => (p.id ==
                  users
                      .where((user) => (user.uid == uid))
                      .first
                      .cart
                      .keys
                      .toList()[i]))
              .first
              .price);
    }
    return total.toString();
  }
}
