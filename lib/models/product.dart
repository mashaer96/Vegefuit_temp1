import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//enum Type { Vegetables, Fruits, Herbs }

class Product {
  final String id;
  String titleAr;
  String titleEn;
  double price;
  String priceDescription;
  String image;
  Color color;
  String type;
  bool isFavorite;
  bool isSelected;
  double weight;
  double quantity;
  String proDate;
  String expDate;

  Product({
    @required this.id,
    @required this.titleAr,
    @required this.titleEn,
    @required this.price,
    @required this.priceDescription,
    @required this.image,
    @required this.color,
    @required this.type,
    @required this.isFavorite,
    @required this.isSelected,
    this.weight,
    @required this.quantity,
    @required this.proDate,
    @required this.expDate,
  });
}
