import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
import '../models/product.dart';
import '../models/user.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String _id = routeArgs['id'];
    final allProducstList = Provider.of<List<Product>>(context);
    final favourites = Provider.of<List<UserAuth>>(context);

    return Scaffold(
      key: _key,
      backgroundColor: (allProducstList != null)
          ? allProducstList.where((p) => (p.id == _id)).toList()[0].color
          : null,
      body: (allProducstList != null)
          ? Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width) * 0.12,
                            height: (height) * 0.07,
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
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/cartScreen');
                          },
                          child: Container(
                            width: (width) * 0.12,
                            height: (height) * 0.07,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: (height) * 0.3,
                      child: Hero(
                        tag: isArabic(context)
                            ? allProducstList
                                .where((p) => (p.id == _id))
                                .toList()[0]
                                .titleAr
                            : allProducstList
                                .where((p) => (p.id == _id))
                                .toList()[0]
                                .titleEn,
                        child: Image.network(
                          allProducstList
                              .where((p) => (p.id == _id))
                              .toList()[0]
                              .image,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
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
                                  height: (height) * 0.05,
                                ),
                                Container(
                                  height: (height) * 0.033,
                                  child: FittedBox(
                                    child: Text(
                                      isArabic(context)
                                          ? allProducstList
                                              .where((p) => (p.id == _id))
                                              .toList()[0]
                                              .titleAr
                                          : allProducstList
                                              .where((p) => (p.id == _id))
                                              .toList()[0]
                                              .titleEn,
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
                              height: (height) * 0.029,
                              child: Text(
                                getTranslated(
                                    context,
                                    allProducstList
                                        .where((p) => (p.id == _id))
                                        .toList()[0]
                                        .priceDescription),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (height) * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: (height) * 0.033,
                                  child: FittedBox(
                                    child: Text(
                                      isArabic(context)
                                          ? allProducstList
                                                  .where((p) => (p.id == _id))
                                                  .toList()[0]
                                                  .price
                                                  .toString() +
                                              ' ريال'
                                          : allProducstList
                                                  .where((p) => (p.id == _id))
                                                  .toList()[0]
                                                  .price
                                                  .toString() +
                                              ' SR',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: (height) * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 48,
                                      height: (height) * 0.074,
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
                                      child: IconButton(
                                        icon: Icon(Icons.remove),
                                        color: Colors.black,
                                        onPressed: _remove,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[300],
                                      width: 48,
                                      height: (height) * 0.074,
                                      child: Center(
                                        child: Text(
                                          '$_quantity',
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
                                      height: (height) * 0.074,
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
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        color: Colors.black,
                                        onPressed: _add,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: (height) * 0.03,
                            ),
                            Container(
                              height: (height) * 0.113975,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: (height) * 0.3,
                                    width: (width) * 0.19,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: Border.all(
                                        color: allProducstList
                                            .where((p) => (p.id == _id))
                                            .toList()[0]
                                            .color,
                                        width: 2,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        favourites
                                                .where(
                                                    (user) => (user.uid == uid))
                                                .first
                                                .favourites
                                                .contains(_id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: allProducstList
                                            .where((p) => (p.id == _id))
                                            .toList()[0]
                                            .color,
                                        size: 36,
                                      ),
                                      onPressed: () {
                                        favourites
                                                .where(
                                                    (user) => (user.uid == uid))
                                                .first
                                                .favourites
                                                .contains(_id)
                                            ? _removeFavourites(_id)
                                            : _addFavourites(_id);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: RaisedButton(
                                      child: Center(
                                        child: Text(
                                          allProducstList
                                                  .where((p) => (p.id == _id))
                                                  .toList()[0]
                                                  .isOutOfStuck
                                              ? getTranslated(
                                                  context, 'outOfStuck')
                                              : getTranslated(
                                                  context, 'addToCart'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      textColor: Colors.black,
                                      color: allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .color,
                                      disabledTextColor: Colors.white,
                                      disabledColor: Color(0xFF808080),
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: allProducstList
                                              .where((p) => (p.id == _id))
                                              .toList()[0]
                                              .isOutOfStuck
                                          ? null
                                          : () {
                                              favourites
                                                      .where((user) =>
                                                          (user.uid == uid))
                                                      .first
                                                      .cart
                                                      .containsKey(_id)
                                                  ? _addToCart(
                                                      _id,
                                                      favourites
                                                          .where((user) =>
                                                              (user.uid == uid))
                                                          .first
                                                          .cart[_id])
                                                  : _addToCart(_id, 0);
                                            },
                                    ),
                                  ),
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
            )
          : Center(
              child: Text(getTranslated(context, 'loading')),
            ),
    );
  }

  void _add() {
    setState(() {
      _quantity++;
    });
  }

  void _remove() {
    if (_quantity <= 1) {
      setState(() {
        _quantity = 0;
      });
    }
    if (_quantity > 1)
      setState(() {
        _quantity--;
      });
  }

  Future<void> _removeFavourites(String item) async {
    try {
      await (FirebaseFirestore.instance.collection('users').doc(uid).update({
        'favourites': FieldValue.arrayRemove([item])
      }));
    } catch (ex) {
      print(ex);
      _key.currentState.showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  Future<void> _addFavourites(String item) async {
    try {
      await (FirebaseFirestore.instance.collection('users').doc(uid).update({
        'favourites': FieldValue.arrayUnion([item])
      }));
    } catch (ex) {
      print(ex);
      _key.currentState.showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  Future<void> _addToCart(String item, var qnt) async {
    try {
      var newQuantity = qnt + _quantity;
      // using cart. prevent the replacement of the exsisting items when using update()
      await (FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'cart.$item': newQuantity}));
    } catch (ex) {
      print(ex);
      _key.currentState.showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }
}
