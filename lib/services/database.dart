import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import '../models/product.dart';

class Database {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
      return Product(
        id: doc.id ?? '',
        titleAr: doc.data()['titleAr'] ?? '',
        titleEn: doc.data()['titleEn'] ?? '',
        price: doc.data()['price'] ?? 0.0,
        priceDescription: doc.data()['price_description'] ?? '',
        image: doc.data()['image'] ??
            'https://firebasestorage.googleapis.com/v0/b/newvegefruit.appspot.com/o/camera.png?alt=media&token=fb8c8384-03b3-43d7-b24b-a546b7bba8bc',
        color: Color(int.parse(doc.data()['color'].substring(6, 16))) ??
            Color(0xFF79DE64),
        type: doc.data()['type'] ?? '',
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
    return productsCollection.snapshots().map(_productsListFromSnapshot);
  }

  Future<void> userSetup(String phone) async {
    String uid = auth.currentUser.uid;
    usersCollection.doc(uid).set({
      'uid': uid,
      'phone': phone,
      'name': '',
      'favourites': [],
      'cart': {},
      'orders': [],
    });
  }

  List<UserAuth> _userFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserAuth(
        uid: doc.data()['uid'],
        phone: doc.data()['phone'],
        name: doc.data()['name'],
        favourites: doc.data()['favourites'],
        cart: doc.data()['cart'],
        orders: doc.data()['orders'],
      );
    }).toList();
  }

  Stream<List<UserAuth>> get users {
    return usersCollection.snapshots().map(_userFromSnapshot);
  }

  Future<List<UserAuth>> get currentUser async {
    final String uid = auth.currentUser.uid.toString();
    List<UserAuth> users = await Database().users.first;
    return users.where((user) => (user.uid == uid));
    //return usersCollection.snapshots().map(_userFromSnapshot).where((user) => user.uid== uid).toList();
  } // (userList) => (userList.where((user) => (user.uid == uid)))
}
