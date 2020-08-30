import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vegefruit/models/is_arabic.dart';

class RenderGridItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String priceDescription;
  final String imageUrl;
  final Color color;
  //bool isFavorite;

  RenderGridItem(
      {this.id,
      this.title,
      this.price,
      this.priceDescription,
      this.imageUrl,
      this.color});

  void _selectedProduct(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/productDetails',
      arguments: {
        'id': id,
        'title': title,
        'price': price,
        'priceDescription': priceDescription,
        'imageUrl': imageUrl,
        'color': color,
      },
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
          child: Container(
            decoration: BoxDecoration(
              color: color,
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
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: title,
                      child: Image.asset(
                        imageUrl,
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
                                    ? price.toString() + ' ريال'
                                    : price.toString() + ' SR',
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
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 16,
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
        ),
      ),
    );
  }
}
