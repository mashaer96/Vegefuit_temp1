import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/date_picking.dart';
import '../widgets/dropdown.dart';
import '../models/product.dart';
import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

class EditProductsScreen extends StatefulWidget {
  static _EditProductsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType();
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _titleAr;
  String _titleEn;
  String _dropdownValueType;
  String _dropdownValueUnit;
  String _price;
  String _weight;
  String _quantity;

  Color _currentColor;

  String _proDateField = '';
  String _expDateField = '';
  DateTime _proDate;
  DateTime _expDate;

  String _image = '';
  File _imageFile;

  String _getType(String _input) {
    if (_input == getTranslated(context, 'vegetables')) {
      setState(() {
        _dropdownValueType = 'vegetables';
      });
    }
    if (_input == getTranslated(context, 'fruits')) {
      setState(() {
        _dropdownValueType = 'fruits';
      });
    }
    if (_input == getTranslated(context, 'herbs')) {
      setState(() {
        _dropdownValueType = 'herbs';
      });
    }
    return _dropdownValueType;
  }

  String _getUnit(String _input) {
    if (_input == getTranslated(context, 'perKilo')) {
      setState(() {
        _dropdownValueUnit = 'perKilo';
      });
    }
    if (_input == getTranslated(context, 'perUnit')) {
      setState(() {
        _dropdownValueUnit = 'perUnit';
      });
    }
    if (_input == getTranslated(context, 'perBag')) {
      setState(() {
        _dropdownValueUnit = 'perBag';
      });
    }
    if (_input == getTranslated(context, 'perBox')) {
      setState(() {
        _dropdownValueUnit = 'perBox';
      });
    }
    return _dropdownValueUnit;
  }

  void _proDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(
        () {
          _proDate = pickedDate;
        },
      );
    });
  }

  void _expDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2090),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(
        () {
          _expDate = pickedDate;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String _id = routeArgs['id'];
    final allProducstList = Provider.of<List<Product>>(context);

    final _titleEnHint = getTranslated(context, 'titleEn');
    final _titleArHint = getTranslated(context, 'titleAr');
    final _priceHint = getTranslated(context, 'price');
    final _priceDescriptionHint = getTranslated(context, 'priceDescription');
    final _weightHint = getTranslated(context, 'kilos');
    final _typeHint = getTranslated(context, 'type');
    final _proDateHint = getTranslated(context, 'pro');
    final _expDateHint = getTranslated(context, 'exp');
    final List<String> _priceDescriptionList = [
      getTranslated(context, 'perKilo'),
      getTranslated(context, 'perUnit'),
      getTranslated(context, 'perBag'),
      getTranslated(context, 'perBox'),
    ];
    final List<String> _typeList = [
      getTranslated(context, 'vegetables'),
      getTranslated(context, 'fruits'),
      getTranslated(context, 'herbs'),
    ];

    Future<String> _uploadImageAndGetURL(String fileName, File file) async {
      FirebaseStorage _storage = FirebaseStorage.instance;
      StorageUploadTask _task = _storage
          .ref()
          .child(fileName)
          .putFile(file, StorageMetadata(contentType: 'image/png'));
      final String _downloadURL =
          await (await _task.onComplete).ref.getDownloadURL();
      return _downloadURL;
    }

    _updateProduct() async {
      //check if empty
      if (formKey.currentState.validate()) {
        try {
          await _firestore.collection('products').doc(_id).update({
            //check if null
            'titleAr': _titleAr == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .titleAr
                : _titleAr,
            'titleEn': _titleEn == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .titleEn
                : _titleEn,
            'type': _dropdownValueType == null
                ? allProducstList.where((p) => (p.id == _id)).toList()[0].type
                : _dropdownValueType,
            'price': _price == null
                ? allProducstList.where((p) => (p.id == _id)).toList()[0].price
                : double.parse(_price),
            'price_description': _dropdownValueUnit == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .priceDescription
                : _dropdownValueUnit,
            'weight': _weight == null || _weight.isEmpty
                ? allProducstList.where((p) => (p.id == _id)).toList()[0].weight
                : double.parse(_weight),
            'color': _currentColor == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .color
                    .toString()
                : _currentColor.toString(),
            'quantity': _quantity == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .quantity
                : double.parse(_quantity),
            'production_date': _proDate == null
                ? (allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .proDate)
                : DateFormat.yMd().format(_proDate),
            'expiration_date': _expDate == null
                ? allProducstList
                    .where((p) => (p.id == _id))
                    .toList()[0]
                    .expDate
                : DateFormat.yMd().format(_expDate),
          });

          if (_imageFile != null) {
            _key.currentState.removeCurrentSnackBar();
            _key.currentState.showSnackBar((SnackBar(
                content: Text(getTranslated(context, 'uploadingImage')))));
            String _url = await _uploadImageAndGetURL(_id, _imageFile);
            await _firestore
                .collection('products')
                .doc(_id)
                .update({"image": _url});
          }

          _key.currentState.removeCurrentSnackBar();
          _key.currentState.showSnackBar((SnackBar(
              content: Text(getTranslated(context, 'successfullAdd')))));
          //to let the user see the snackBar
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        } catch (ex) {
          print(ex);
          _key.currentState
              .showSnackBar((SnackBar(content: Text(ex.toString()))));
        }
      }
    }

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      backgroundColor: _currentColor == null
          ? allProducstList.where((p) => (p.id == _id)).toList()[0].color
          : _currentColor,
      body: (allProducstList != null)
          ? ListView(
              padding: EdgeInsets.all(0),
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
                      //Back button
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
                      //Picking color button
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Select a color'),
                                content: SingleChildScrollView(
                                  child: Container(
                                    height: (height) * 0.2,
                                    child: BlockPicker(
                                      pickerColor: allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .color,
                                      onColorChanged: (value) {
                                        setState(() {
                                          _currentColor = value;
                                        });
                                        Navigator.pop(context);
                                      },
                                      availableColors: [
                                        Color(0xffffef62),
                                        Color(0xFF9791f4),
                                        Color(0xFF83e06f),
                                        Color(0xFFf9913e),
                                        Color(0xFFef8bed),
                                        Color(0xFFff5562),
                                        Color(0xFF5cbcff),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
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
                            Icons.color_lens,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Picking Image area
                Center(
                  child: SizedBox(
                    height: (height) * 0.3,
                    child: GestureDetector(
                      onTap: () async {
                        File image =
                            // ignore: deprecated_member_use
                            await ImagePicker.pickImage(
                                source: ImageSource.gallery);
                        setState(() {
                          _imageFile = image;
                        });
                      },
                      child: _imageFile == null
                          ? Image.network(
                              allProducstList
                                  .where((p) => (p.id == _id))
                                  .toList()[0]
                                  .image,
                            )
                          : Image.file(_imageFile),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Container(
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
                    padding: EdgeInsets.only(
                      left: 0.0,
                      right: 0.0,
                      bottom: mq.viewInsets.bottom + 90,
                      top: 0.0,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, right: 32.0, left: 15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Arabic title text field
                            Row(
                              children: [
                                Container(
                                  height: (height) * 0.08,
                                  width: (width) * 0.5,
                                  child: TextFormField(
                                    initialValue: allProducstList
                                        .where((p) => (p.id == _id))
                                        .toList()[0]
                                        .titleAr,
                                    decoration: InputDecoration(
                                      hintText: _titleArHint,
                                    ),
                                    keyboardType: TextInputType.name,
                                    cursorColor: Theme.of(context).primaryColor,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _titleAr = newValue;
                                      });
                                    },
                                    validator: (String input) {
                                      if (input.isEmpty) {
                                        return getTranslated(
                                            context, 'required');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // English title text field
                            Row(
                              children: [
                                Container(
                                  height: (height) * 0.08,
                                  width: (width) * 0.5,
                                  child: TextFormField(
                                    initialValue: allProducstList
                                        .where((p) => (p.id == _id))
                                        .toList()[0]
                                        .titleEn,
                                    decoration: InputDecoration(
                                      hintText: _titleEnHint,
                                    ),
                                    keyboardType: TextInputType.name,
                                    cursorColor: Theme.of(context).primaryColor,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _titleEn = newValue;
                                      });
                                    },
                                    validator: (String input) {
                                      if (input.isEmpty) {
                                        return getTranslated(
                                            context, 'required');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                //Type dropdown list
                                DropdownWidget(
                                  hint: _typeHint,
                                  initValue: getTranslated(
                                      context,
                                      allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .type),
                                  newValue: _dropdownValueType,
                                  getValue: _getType,
                                  valuesList: _typeList,
                                ),
                                SizedBox(
                                  width: (width) * 0.03,
                                ),
                                //Price text field
                                Container(
                                  height: (height) * 0.08,
                                  width: (width) * 0.17,
                                  child: TextFormField(
                                    initialValue: allProducstList
                                        .where((p) => (p.id == _id))
                                        .toList()[0]
                                        .price
                                        .toString(),
                                    decoration: InputDecoration(
                                      hintText: _priceHint,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9.]")),
                                    ],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _price = newValue;
                                      });
                                    },
                                    validator: (String input) {
                                      if (input.isEmpty) {
                                        return getTranslated(
                                            context, 'required');
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                //Unit dropdown list
                                DropdownWidget(
                                  hint: _priceDescriptionHint,
                                  initValue: getTranslated(
                                      context,
                                      allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .priceDescription),
                                  newValue: _dropdownValueUnit,
                                  getValue: _getUnit,
                                  valuesList: _priceDescriptionList,
                                ),
                                SizedBox(
                                  width: (width) * 0.03,
                                ),
                                //weight text field
                                Container(
                                  height: (height) * 0.08,
                                  width: (width) * 0.17,
                                  child: TextFormField(
                                    initialValue: allProducstList
                                        .where((p) => (p.id == _id))
                                        .toList()[0]
                                        .weight
                                        .toString(),
                                    decoration: InputDecoration(
                                      hintText: _weightHint,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: Theme.of(context).primaryColor,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9.]")),
                                    ],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _weight = newValue;
                                      });
                                    },
                                    validator: (String input) {
                                      if (input.isEmpty) {
                                        if (_dropdownValueUnit == 'perBox' ||
                                            _dropdownValueUnit == 'perBag') {
                                          return getTranslated(
                                              context, 'required');
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: (height) * 0.01,
                            ),
                            Row(
                              children: [
                                //Production date picking
                                DatePickingWidget(
                                  textHint: _proDateHint +
                                      allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .proDate,
                                  pickedDate: _proDate,
                                  pickerFunction: _proDatePicker,
                                ),
                                //Expiration date picking
                                DatePickingWidget(
                                  textHint: _expDateHint +
                                      allProducstList
                                          .where((p) => (p.id == _id))
                                          .toList()[0]
                                          .expDate,
                                  pickedDate: _expDate,
                                  pickerFunction: _expDatePicker,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Quantity text field
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: (width) * 0.39,
                                      height: (height) * 0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      child: Center(
                                        child: TextFormField(
                                          initialValue: allProducstList
                                              .where((p) => (p.id == _id))
                                              .toList()[0]
                                              .quantity
                                              .toString()
                                              .substring(
                                                  0,
                                                  allProducstList
                                                      .where(
                                                          (p) => (p.id == _id))
                                                      .toList()[0]
                                                      .quantity
                                                      .toString()
                                                      .indexOf('.')),
                                          onChanged: (value) {
                                            setState(() {
                                              _quantity = value;
                                            });
                                          },
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            labelText: '  ' +
                                                getTranslated(
                                                    context, 'quantity'),
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9]")),
                                          ],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          validator: (String input) {
                                            if (input.isEmpty) {
                                              return getTranslated(
                                                  context, 'required');
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Save button
                                GestureDetector(
                                  onTap: _updateProduct,
                                  child: Container(
                                    height: (height) * 0.1,
                                    width: (width) * 0.4,
                                    decoration: BoxDecoration(
                                      color: _currentColor == null
                                          ? allProducstList
                                              .where((p) => (p.id == _id))
                                              .toList()[0]
                                              .color
                                          : _currentColor,
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
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text('Loading...'),
            ),
    );
  }
}
