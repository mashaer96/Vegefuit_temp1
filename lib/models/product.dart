import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  String titleAr;
  String titleEn;
  double price;
  String priceDescription;
  String image;
  Color color;
  String type;
  bool isSelected;
  double weight;
  double quantity;
  String proDate;
  String expDate;
  DateTime created;

  Product({
    @required this.id,
    @required this.titleAr,
    @required this.titleEn,
    @required this.price,
    @required this.priceDescription,
    @required this.image,
    @required this.color,
    @required this.type,
    @required this.isSelected,
    @required this.weight,
    @required this.quantity,
    @required this.proDate,
    @required this.expDate,
    @required this.created,
  });

  bool get isOutOfStuck {
    if (quantity == 0 || isSelected == false) {
      return true;
    } else {
      return false;
    }
  }
}
