import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizaaelk/model/Product.dart';

class ProductsProvider with ChangeNotifier {
  /// Explore Product
  List<Product> allProducts = [];
  bool itemsLoading = true;

  StreamSubscription _soldItemsStream;



  void getProducts(String uid) {
    _soldItemsStream = Firestore.instance
        .collection("Products")
        .where("uid", isEqualTo: uid)
        .orderBy('createAt', descending: true)
        .limit(100)
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      if (snapshot.documents.length > 0) {
        allProducts.clear();
        snapshot.documents.forEach(
                (element) => allProducts.add(Product.fromJson(element.data)));
      } else {
        allProducts = [];
      }
      itemsLoading = false;
      notifyListeners();
    }, onError: (e) {
      print(e);
      itemsLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {

    if (_soldItemsStream != null) {
      _soldItemsStream.cancel();
      _soldItemsStream = null;
    }
    super.dispose();
  }
}
