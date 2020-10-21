import 'dart:ui';
import 'package:flutter/material.dart';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

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
          0.35,
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
              Icon(
                Icons.remove_shopping_cart,
                color: Theme.of(context).canvasColor,
                size: 50,
              ),
              Text(
                getTranslated(context, 'outOfStuck'),
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isArabic(context)? 15 : 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    FittedBox(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: FittedBox(
                                child: Text(
                                  isArabic(context)
                                      ? widget.price.toString() + ' ريال'
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
                            SizedBox(
                              width: 9.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0.1),
                                child: IconButton(
                                  icon: new Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // favouritesList.contains(widget.id)
                                      //     ? favouritesList.remove(widget.id)
                                      //     : favouritesList.add(widget.id);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
