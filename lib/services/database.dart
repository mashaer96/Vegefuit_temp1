import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class Database {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  List<Product> __productsListFromSnapshot(QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
      return Product(
        id: doc.id ?? '',
        titleAr: doc.data()['titleAr'] ?? '',
        titleEn: doc.data()['titleEn'] ?? '',
        price: doc.data()['price'] ?? 0.0,
        priceDescription: doc.data()['price_description'] ?? '',
        image: doc.data()['image'] ??
            'https://firebasestorage.googleapis.com/v0/b/vegefruit-305c2.appspot.com/o/camera.png?alt=media&token=4da0a6d4-f44b-44d4-bb00-07ecf2154919',
        color: Color(int.parse(doc.data()['color'].substring(6, 16))) ??
            Color(0xFF79DE64),
        type: doc.data()['type'] ?? '',
        isFavorite: doc.data()['is_favorite'],
        isSelected: doc.data()['is_selected'],
        weight: doc.data()['weight'] ?? 0.0,
        quantity: doc.data()['quantity'] ?? 1.0,
        proDate: doc.data()['production_date'],
        expDate: doc.data()['expiration_date'],
        created: doc.data()['created'].toDate(),
      );
    }).toList();

    list.sort((a, b) {
      return b.created.compareTo(a.created);
    });
    
    return list;
  }

  Stream<List<Product>> get products {
    return productsCollection.snapshots().map(__productsListFromSnapshot);
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<List<Product>> get products {
  //   Stream<List<Product>> productsStream = _firestore
  //       .collection("products")
  //       .snapshots(includeMetadataChanges: true)
  //       .map((QuerySnapshot querySnapshot) => querySnapshot.docs
  //           .map((DocumentSnapshot documentSnapshot) => Product(
  //                 id: documentSnapshot.id ?? '',
  //                 titleAr: documentSnapshot.data()['titleAr'] ?? '',
  //                 titleEn: documentSnapshot.data()['titleEn'] ?? '',
  //                 price: documentSnapshot.data()['price'] ?? 0.0,
  //                 priceDescription:
  //                     documentSnapshot.data()['price_description'] ?? '',
  //                 image: documentSnapshot.data()['image'] ?? '',
  //                 color: Color(int.parse(
  //                         documentSnapshot.data()['color'].substring(6, 16))) ??
  //                     Color(0xFF79DE64),
  //                 type: documentSnapshot.data()['type'] ?? '',
  //                 isFavorite: documentSnapshot.data()['is_favorite'],
  //                 isSelected: documentSnapshot.data()['is_selected'],
  //                 weight: documentSnapshot.data()['weight'] ?? 0.0,
  //                 quantity: documentSnapshot.data()['quantity'] ?? 1,
  //               ))
  //           .toList());

  //   return productsStream;
  // }
}
