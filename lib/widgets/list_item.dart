import 'package:flutter/material.dart';
import '../models/is_arabic.dart';

class ListItem extends StatefulWidget {
  final String title;
  final double price;
  final Color color;
  final String imageUrl;

  ListItem({this.title, this.price, this.color, this.imageUrl});
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  
  int _itemQuantity = 1;

  void _add() {
    setState(() {
      _itemQuantity++;
    });
  }

  void _remove() {
    if (_itemQuantity <= 0) {
      setState(() {
        _itemQuantity = 0;
      });
    }
    if (_itemQuantity > 0)
      setState(() {
        _itemQuantity--;
      });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
    return Card(
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
          Container(
            width: (width) * 0.23,
            height: (height) *
                0.15,
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
          SizedBox(
            width: (width) * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: (width) * 0.3,
                height: (height) *
                    0.04,
                //child: FittedBox(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                //),
              ),
              Container(
                width: (width) * 0.15,
                height: (height) *
                    0.03,
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
            width: (width) * 0.08,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: (width) * 0.04,
                height: (height) *
                    0.15,
                child: FittedBox(
                  child: Text(
                    '$_itemQuantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: (width) * 0.025,
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
    );
  }
}
