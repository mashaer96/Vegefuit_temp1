import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/is_arabic.dart';

class ListItem extends StatefulWidget {
  final String id;
  final String title;
  final double price;
  double quantity;
  final Color color;
  final String imageUrl;
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListItem(
      {this.title,
      this.price,
      this.color,
      this.imageUrl,
      this.id,
      this.scaffoldKey,
      this.quantity});
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  Future<void> _removeItem() async {
    try {
      await (FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .update({'is_selected': false}));
    } catch (ex) {
      widget.scaffoldKey.currentState
          .showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  Future<void> _updateQuantity() async {
    try {
      await (FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .update({'quantity': widget.quantity}));
    } catch (ex) {
      widget.scaffoldKey.currentState
          .showSnackBar((SnackBar(content: Text(ex.toString()))));
    }
  }

  void _add() {
    setState(() {
      widget.quantity++;
    });
    _updateQuantity();
  }

  void _remove() {
    if (widget.quantity <= 0) {
      setState(() {
        widget.quantity = 0;
      });
      _updateQuantity();
      _removeItem();
    }
    if (widget.quantity > 0) {
      setState(() {
        widget.quantity--;
      });
      _updateQuantity();
    }
  }

  void _showItem(BuildContext ctx) {
    Navigator.pushNamed(context, '/editProductsScreen',
        arguments: {'id': widget.id});
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

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
              child: Container(
                width: (width) * 0.23,
                height: (height) * 0.15,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    widget.imageUrl,
                  ),
                ),
              ),
              onTap: () => _showItem(context),
            ),
            SizedBox(
              width: (width) * 0.05,
            ),
            Column(
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
                      widget.quantity.toString().substring(
                          0, widget.quantity.toString().indexOf('.')),
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
