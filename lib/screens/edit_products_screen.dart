import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/color_picker.dart';
import '../widgets/date_picking.dart';
import '../widgets/double_field.dart';
import '../widgets/dropdown.dart';
import '../widgets/title_field.dart';
import '../models/product.dart';
import '../localization/demo_localization.dart';
import '../models/is_arabic.dart';

class EditProductsScreen extends StatefulWidget {
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime _proDate;
  DateTime _expDate;
  File _imageFile;

  ///////////////////////////////////////
  String _title; ////////////////////////
  String _priceDescription; ////////////
  String _price; //////////////////////
  ///////////////////////////////////

  // void _submit() {
  //   if (formKey.currentState.validate()) {
  //     formKey.currentState.save();
  //     print(_title);
  //     print(_priceDescription);
  //     print(_price);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top;
    final width = mq.size.width;
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

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String _id = routeArgs['id'];
    final allProducstList = Provider.of<List<Product>>(context);
    List<Product> product =
        allProducstList.where((p) => (p.id == _id)).toList();
    TextEditingController _newTitleArController =
        TextEditingController(text: product[0].titleAr);
    TextEditingController _newTitleEnController =
        TextEditingController(text: product[0].titleEn);
    String _dropdownValueType = getTranslated(context, product[0].type);
    TextEditingController _newPriceController =
        TextEditingController(text: product[0].price.toString());
    String _dropdownValueUnit =
        getTranslated(context, product[0].priceDescription);
    TextEditingController _newWeightController =
        TextEditingController(text: product[0].weight.toString());
    int _quantity = int.parse(product[0]
        .quantity
        .toString()
        .substring(0, product[0].quantity.toString().indexOf('.')));
    TextEditingController _newQuantityController =
        TextEditingController(text: _quantity.toString());

    Color _currentColor = product[0].color;
    //DateTime _selectedDate;
    String _proDateField = product[0].proDate;
    String _expDateField = product[0].expDate;
    String _image = product[0].image;

    _updateProduct() async {
      //   if (formKey.currentState.validate()) {
      //     DocumentReference ref;
      //     if (_proDate == null) {
      //       setState(() {
      //         _proDate = DateTime.now();
      //       });
      //     }
      //     if (_expDate == null) {
      //       setState(() {
      //         _expDate = DateTime.now().add(Duration(days: 3));
      //       });
      //     }

      //     try {
      //       ref = await _firestore.collection('products').add({
      //         'titleAr': _newTitleArController.text.trim(),
      //         'titleEn':
      //             _newTitleEnController.text.trim().substring(0, 1).toUpperCase() +
      //                 _newTitleEnController.text.trim().substring(1),
      //         'type': _dropdownValueType,
      //         'price': double.parse(_newPriceController.text.trim()),
      //         'price_description': _dropdownValueUnit,
      //         'weight': double.parse(_newWeightController.text.trim()),
      //         'color': _currentColor.toString(),
      //         'quantity': double.parse(_newQuantityController.text.trim()),
      //         'production_date': DateFormat.yMd().format(_proDate),
      //         'expiration_date': DateFormat.yMd().format(_expDate),
      //         'is_selected': false,
      //         'is_favorite': false,
      //       });
      //       if (_image != null) {
      //         _key.currentState.removeCurrentSnackBar();
      //         _key.currentState.showSnackBar((SnackBar(
      //             content: Text(getTranslated(context, 'uploadingImage')))));

      //         String _url = await _uploadImageAndGetURL(ref.id, _imageFile);

      //         await ref.update({"image": _url});
      //       }

      //       _key.currentState.removeCurrentSnackBar();
      //       _key.currentState.showSnackBar((SnackBar(
      //           content: Text(getTranslated(context, 'successfullAdd')))));
      //       //to let the user see the snackBar
      //       Future.delayed(Duration(seconds: 1), () {
      //         Navigator.pop(context);
      //       });
      //     } catch (ex) {
      //       print(ex);
      //       _key.currentState
      //           .showSnackBar((SnackBar(content: Text(ex.toString()))));
      //     }
      //   }
    }

    // Future<String> _uploadImageAndGetURL(String fileName, File file) async {
    //   FirebaseStorage _storage = FirebaseStorage.instance;
    //   StorageUploadTask _task = _storage
    //       .ref()
    //       .child(fileName)
    //       .putFile(file, StorageMetadata(contentType: 'image/png'));
    //   final String _downloadURL =
    //       await (await _task.onComplete).ref.getDownloadURL();
    //   return _downloadURL;
    // }

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

    void _add() {
      setState(() {
        _quantity++;
        _newQuantityController =
            TextEditingController(text: _quantity.toString());
        print(_quantity);
        print(_newQuantityController);
      });
    }

    void _remove() {
      if (_quantity <= 1) {
        setState(() {
          _quantity = 1;
          _newQuantityController = TextEditingController(text: '$_quantity');
        });
      }
      if (_quantity > 1)
        setState(() {
          _quantity--;
          _newQuantityController = TextEditingController(text: '$_quantity');
        });
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

    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      backgroundColor: _currentColor,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: (width) * 0.07,
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
                      ColorPickerWidget(_currentColor, changeColor),
                    ],
                  ),
                ),
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
                              _image,
                            )
                          : Image.file(_imageFile),
                    ),
                  ),
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
                          EdgeInsets.only(top: 42.0, right: 32.0, left: 15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TitleFieldWidget(
                              titleHint: _titleArHint,
                              titleController: _newTitleArController,
                            ),
                            TitleFieldWidget(
                              titleHint: _titleEnHint,
                              titleController: _newTitleEnController,
                            ),
                            Row(
                              children: <Widget>[
                                DropdownWidget(
                                  hint: _typeHint,
                                  value: _dropdownValueType,
                                  getValue: _getType,
                                  valuesList: _typeList,
                                ),
                                SizedBox(
                                  width: (width) * 0.03,
                                ),
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
                                DropdownWidget(
                                  hint: _priceDescriptionHint,
                                  value: _dropdownValueUnit,
                                  getValue: _getUnit,
                                  valuesList: _priceDescriptionList,
                                ),
                                SizedBox(
                                  width: (width) * 0.03,
                                ),
                                DoubleFieldWidget(
                                  doubleHint: _kilosHint,
                                  doubleController: _newWeightController,
                                  isKilo: true,
                                  validateRelated: _dropdownValueUnit,
                                ),
                                SizedBox(
                                  width: (width) * 0.05,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: (height) * 0.01,
                            ),
                            Row(
                              children: [
                                DatePickingWidget(
                                  textHint: _proDateHint + _proDateField,
                                  color: _currentColor,
                                  pickedDate: _proDate,
                                  pickerFunction: _proDatePicker,
                                ),
                                DatePickingWidget(
                                  textHint: _expDateHint + _expDateField,
                                  color: _currentColor,
                                  pickedDate: _expDate,
                                  pickerFunction: _expDatePicker,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: (width) * 0.13,
                                      height: (height) * 0.1,
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
                                      width: (width) * 0.13,
                                      height: (height) * 0.1,
                                      child: Center(
                                        child: TextFormField(
                                          controller: _newQuantityController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
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
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: (width) * 0.13,
                                      height: (height) * 0.1,
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
                                GestureDetector(
                                  onTap: _updateProduct,
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
                ),
              ],
            )
          : Center(
              child: Text('Loading...'),
            ),
    );
  }
}
