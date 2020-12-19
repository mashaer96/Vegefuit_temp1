import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../widgets/double_field.dart';
import '../widgets/dropdown.dart';
import '../widgets/title_field.dart';
import '../widgets/color_picker.dart';
import '../widgets/date_picking.dart';
import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

class AddProductScreen extends StatefulWidget {
  //static _AddProductScreenState of(BuildContext context) => context.findAncestorStateOfType();
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _newTitleArController = TextEditingController(text: '');
  TextEditingController _newTitleEnController = TextEditingController(text: '');
  String _dropdownValueType;
  TextEditingController _newPriceController = TextEditingController(text: '');
  String _dropdownValueUnit;
  TextEditingController _newWeightController = TextEditingController(text: '');
  TextEditingController _newQuantityController =
      TextEditingController(text: '1');
  Color _currentColor = Color(0xFF79DE64);
  File _image;
  //DateTime _selectedDate;
  DateTime _proDate;
  DateTime _expDate;

  _addProduct() async {
    if (formKey.currentState.validate()) {
      DocumentReference ref;
      if (_proDate == null) {
        setState(() {
          _proDate = DateTime.now();
        });
      }
      if (_expDate == null) {
        setState(() {
          _expDate = DateTime.now().add(Duration(days: 3));
        });
      }
      if (_newWeightController.text.trim().isEmpty ||
          _newWeightController.text.trim() == null) {
        _newWeightController.text = '0.0';
      }

      try {
        ref = await _firestore.collection('products').add({
          'titleAr': _newTitleArController.text.trim(),
          'titleEn':
              _newTitleEnController.text.trim().substring(0, 1).toUpperCase() +
                  _newTitleEnController.text.trim().substring(1),
          'type': _dropdownValueType,
          'price': double.parse(_newPriceController.text.trim()),
          'price_description': _dropdownValueUnit,
          'weight': double.parse(_newWeightController.text.trim()),
          'color': _currentColor.toString(),
          'quantity': double.parse(_newQuantityController.text.trim()),
          'production_date': DateFormat.yMd().format(_proDate),
          'expiration_date': DateFormat.yMd().format(_expDate),
          'created': DateTime.now(),
          'is_selected': false,
        });
        if (_image != null) {
          _key.currentState.removeCurrentSnackBar();
          _key.currentState.showSnackBar((SnackBar(
              content: Text(getTranslated(context, 'uploadingImage')))));

          String _url = await _uploadImageAndGetURL(ref.id, _image);

          await ref.update({"image": _url});
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

  void changeColor(Color color) => setState(() {
        _currentColor = color;
        Navigator.pop(context);
      });

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
    final _titleEnHint = getTranslated(context, 'titleEn');
    final _titleArHint = getTranslated(context, 'titleAr');
    final _priceHint = getTranslated(context, 'price');
    final _priceDescriptionHint = getTranslated(context, 'priceDescription');
    final _kilosHint = getTranslated(context, 'kilos');
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

    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;

    return Scaffold(
      key: _key,
      backgroundColor: _currentColor,
      body: new InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
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
                  ColorPickerWidget(_currentColor, changeColor),
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
                      _image = image;
                    });
                  },
                  child: _image == null
                      ? Image.asset(
                          'assets/images/camera.png',
                        )
                      : Image.file(_image),
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
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  right: 32.0,
                  left: 15.0,
                  bottom: mq.viewInsets.bottom,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Arabic title text field
                      TitleFieldWidget(
                        titleHint: _titleArHint,
                        titleController: _newTitleArController,
                      ),
                      // English title text field
                      TitleFieldWidget(
                        titleHint: _titleEnHint,
                        titleController: _newTitleEnController,
                      ),
                      Row(
                        children: <Widget>[
                          //Type dropdown list
                          DropdownWidget(
                            hint: _typeHint,
                            newValue: _dropdownValueType,
                            getValue: _getType,
                            valuesList: _typeList,
                          ),
                          SizedBox(
                            width: (width) * 0.03,
                          ),
                          //Price text field
                          DoubleFieldWidget(
                            doubleHint: _priceHint,
                            doubleController: _newPriceController,
                            isKilo: false,
                            validateRelated: _dropdownValueType,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          //Unit dropdown list
                          DropdownWidget(
                            hint: _priceDescriptionHint,
                            newValue: _dropdownValueUnit,
                            getValue: _getUnit,
                            valuesList: _priceDescriptionList,
                          ),
                          SizedBox(
                            width: (width) * 0.03,
                          ),
                          //weight text field
                          DoubleFieldWidget(
                            doubleHint: _kilosHint,
                            doubleController: _newWeightController,
                            isKilo: true,
                            validateRelated: _dropdownValueUnit,
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
                            textHint: _proDateHint,
                            pickedDate: _proDate,
                            pickerFunction: _proDatePicker,
                          ),
                          //Expiration date picking
                          DatePickingWidget(
                            textHint: _expDateHint,
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
                                    controller: _newQuantityController,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      labelText: '  ' +
                                          getTranslated(context, 'quantity'),
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
                            onTap: _addProduct,
                            child: Container(
                              height: (height) * 0.1,
                              width: (width) * 0.4,
                              decoration: BoxDecoration(
                                color: _currentColor,
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
          ],
        ),
      ),
    );
  }
}
