import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';
import '../models/user.dart';

class RenderGridItem extends StatefulWidget {
  final String id;
  final String title;
  final double price;
  final String priceDescription;
  final String imageUrl;
  final Color color;
  final double quantity;
  final bool isSelected;

  RenderGridItem(
      {this.id,
      this.title,
      this.price,
      this.priceDescription,
      this.imageUrl,
      this.color,
      this.quantity,
      this.isSelected});

  @override
  _RenderGridItemState createState() => _RenderGridItemState();
}

class _RenderGridItemState extends State<RenderGridItem> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final String uid = FirebaseAuth.instance.currentUser.uid.toString();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height =
        mq.size.height - AppBar().preferredSize.height - mq.padding.top;
    final width = mq.size.width;
    final favourites = Provider.of<List<UserAuth>>(context);

    return (favourites != null)
        ? InkWell(
            onTap: () => _selectedProduct(context),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            child: GridTile(
              child: Material(
                elevation: 10,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
                child: Stack(children: <Widget>[
                  Container(
                    height: height * 0.4,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: height * 0.05,
                            width: width * 0.5,
                            child: FittedBox(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Hero(
                              tag: widget.title,
                              child: Image.network(
                                widget.imageUrl,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Container(
                                height: height * 0.09,
                                width: width * 0.3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: height * 0.035,
                                      width: width * 0.15,
                                      child: FittedBox(
                                        child: Text(
                                          isArabic(context)
                                              ? widget.price.toString() +
                                                  ' ريال'
                                              : widget.price.toString() + ' SR',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: width * 0.03,
                                    // ),
                                    Container(
                                      height: height * 0.13,
                                      width: width * 0.13,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.1),
                                        child: IconButton(
                                          icon: Icon(
                                            favourites
                                                    .where((user) =>
                                                        (user.uid == uid))
                                                    .first
                                                    .favourites
                                                    .contains(widget.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                          onPressed: () {
                                            favourites
                                                    .where((user) =>
                                                        (user.uid == uid))
                                                    .first
                                                    .favourites
                                                    .contains(widget.id)
                                                ? _removeFavourites(widget.id)
                                                : _addFavourites(widget.id);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.isSelected == false || widget.quantity == 0
                      ? _outOfStuck()
                      : Container(),
                ]),
              ),
            ),
          )
        : Center(
            child: Text(getTranslated(context, 'loading')),
          );
  }

  void _selectedProduct(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/productDetails',
      arguments: {
        'id': widget.id,
      },
    );
  }

  Widget _outOfStuck() {
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.4,
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top) *
          0.4,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.1,
                width: (MediaQuery.of(context).size.width) * 0.2,
                child: Icon(
                  Icons.remove_shopping_cart,
                  color: Theme.of(context).canvasColor,
                  size: 50,
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.05,
                width: (MediaQuery.of(context).size.width) * 0.3,
                child: Text(
                  getTranslated(context, 'outOfStuck'),
                  style: TextStyle(
                    color: Theme.of(context).canvasColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isArabic(context) ? 15 : 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
