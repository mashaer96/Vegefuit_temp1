import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Type { Vegetables, Fruits, Herbs }

class Product {
  final String id;
  final String titleAr;
  final String titleEn;
  final double price;
  final String priceDescriptionAr;
  final String priceDescriptionEn;
  final String imageUrl;
  final Color color;
  final Type type;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.titleAr,
    @required this.titleEn,
    @required this.price,
    @required this.priceDescriptionAr,
    @required this.priceDescriptionEn,
    @required this.imageUrl,
    @required this.color,
    @required this.type,
    this.isFavorite = false,
  });
}