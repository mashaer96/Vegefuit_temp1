import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegefruit/localization/demo_localization.dart';
import 'package:vegefruit/models/product.dart';
import 'package:vegefruit/models/user.dart';
import '../models/is_arabic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// ignore: must_be_immutable
class CartItem extends StatefulWidget {
  final String id;
  final String title;
  final double price;
  var quantity;
  final Color color;
  final String imageUrl;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CartItem(
      {this.title,
      this.price,
      this.color,
      this.imageUrl,
      this.id,
      this.scaffoldKey,
      this.quantity});
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();

  Future<void> _removeItem() async {
    String id = widget.id;
    try {
      await (FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'cart.$id': FieldValue.delete()}));
    } catch (ex) {
      widget.scaffoldKey.currentState
          .showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  Future<void> _updateQuantity() async {
    String id = widget.id;
    // int qnt = int.parse(widget.quantity.toString());
    try {
      await (FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'cart.$id': widget.quantity}));
    } catch (ex) {
      widget.scaffoldKey.currentState
          .showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  void _showItem() {
    Navigator.pushNamed(context, '/productDetails', arguments: {
      'id': widget.id,
    });
  }

  Widget _removeItemRetunWidget() {
    _removeItem();
    return Container();
  }

  Widget _outOfStuck() {
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.23,
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top) *
          0.15,
      decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 18),
        child: Text(
          getTranslated(context, 'outOfStuck'),
          style: TextStyle(
            color: Theme.of(context).canvasColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: 'Stock Limit',
      desc: 'This is my message.',
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void _add() {
    final allProductList = Provider.of<List<Product>>(context, listen: false);
    if (widget.quantity >=
        allProductList.where((p) => (p.id == widget.id)).first.quantity) {
      showAlertDialog(context);
    } else {
      setState(() {
        widget.quantity++;
      });
      _updateQuantity();
    }
  }

  void _remove() {
    if (widget.quantity <= 0) {
      setState(() {
        widget.quantity = 0;
      });
      _removeItem();
    }
    if (widget.quantity > 0) {
      setState(() {
        widget.quantity--;
      });
      _updateQuantity();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    final allProductList = Provider.of<List<Product>>(context);
    final users = Provider.of<List<UserAuth>>(context);

    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _removeItem(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).canvasColor,
          size: 35,
        ),
        alignment:
            isArabic(context) ? Alignment.centerLeft : Alignment.centerRight,
        padding: isArabic(context)
            ? EdgeInsets.only(left: 20)
            : EdgeInsets.only(right: 20),
        margin: const EdgeInsets.all(10.0),
      ),
      child: Card(
        margin: const EdgeInsets.all(10.0),
        color: Theme.of(context).canvasColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: _showItem,
              child: Container(
                width: (width) * 0.23,
                height: (height) * 0.15,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                        widget.imageUrl,
                      ),
                    ),
                    allProductList
                                .where((p) => (p.id == widget.id))
                                .first
                                .quantity ==
                            0.0
                        ? _outOfStuck()
                        : Container()
                  ],
                ),
              ),
            ),
            widget.quantity == 0 ? _removeItemRetunWidget() : Container(),
            SizedBox(
              width: (width) * 0.05,
            ),
            GestureDetector(
              onTap: _showItem,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (width) * 0.23,
                    height: (height) * 0.04,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: (width) * 0.15,
                    height: (height) * 0.03,
                    child: FittedBox(
                      child: Text(
                        isArabic(context)
                            ? widget.price.toString() + ' ريال'
                            : widget.price.toString() + ' SR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: (width) * 0.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (width) * 0.2,
                  height: (height) * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      widget.quantity.toString().contains('.')
                          ? widget.quantity.toString().substring(
                              0, widget.quantity.toString().indexOf('.'))
                          : widget.quantity.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: _add,
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Container(
                      height: (height) * 0.04,
                      width: (width) * 0.075,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: (height) * 0.025,
                ),
                InkWell(
                  onTap: _remove,
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Container(
                      height: (height) * 0.04,
                      width: (width) * 0.075,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
