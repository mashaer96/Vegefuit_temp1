import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

class EditProductsScreen extends StatefulWidget {
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final formKey = GlobalKey<FormState>();
  String _title;
  String _priceDescription;
  String _price;
  int _quantity = 0;

  void _add() {
    setState(() {
      _quantity++;
    });
  }

  void _remove() {
    if (_quantity <= 0) {
      setState(() {
        _quantity = 0;
      });
    }
    if (_quantity > 0)
      setState(() {
        _quantity--;
      });
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(_title);
      print(_priceDescription);
      print(_price);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    //final id = routeArgs['id'];
    // final title = routeArgs['title'];
    // final price = routeArgs['price'];
    //final priceDescription = routeArgs['priceDescription'];
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Image.asset(
                  imageUrl,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Form(
                      key: formKey,
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
                                    0.039,
                                width:
                                    (MediaQuery.of(context).size.width) * 0.5,
                                // child: FittedBox(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: getTranslated(context, 'title'),
                                  ),
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.lightGreen,
                                  // validator: ,
                                  onSaved: (input) => _title = input,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.039,
                            width: (MediaQuery.of(context).size.width) * 0.5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                    getTranslated(context, 'priceDescription'),
                              ),
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.lightGreen,
                              // validator: ,
                              onSaved: (input) => _priceDescription = input,
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
                                    0.039,
                                width:
                                    (MediaQuery.of(context).size.width) * 0.5,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: getTranslated(context, 'price'),
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.lightGreen,
                                  // validator: ,
                                  onSaved: (input) => _price = input,
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
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
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
                                    child: IconButton(
                                      icon: Icon(Icons.remove),
                                      color: Colors.black,
                                      onPressed: _remove,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey[300],
                                    width: 48,
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
                                            0.074,
                                    child: Center(
                                      child: Text(
                                        '$_quantity', ////////////////////////////////////////////////
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
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
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
                                    Icons.check,
                                    color: color,
                                    size: 36,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  /////////////    SHOULD BE RAISED BUTTON            ////////////////////////////
                                  child: GestureDetector(
                                    onTap: _submit,
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
                                          getTranslated(context, 'save'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
