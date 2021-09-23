import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizaaelk/model/Product.dart';

class ProductsProvider with ChangeNotifier {
  /// Explore Product
  List<Product> allProducts = [];
  bool itemsLoading = true;

  StreamSubscription _soldItemsStream;

  Future addProduct(Product item, String uid) async {
    try {
      item.uid = uid;
      item.createAt = DateTime.now();
      await Firestore.instance.collection("products").add(item.toJson());
    } catch (error) {
      print(error);
    }
  }

  void getProducts() {
    _soldItemsStream = Firestore.instance
        .collection("products")
        .orderBy('createAt', descending: true)
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
