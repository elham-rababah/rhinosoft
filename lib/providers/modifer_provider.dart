import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizaaelk/model/Product.dart';
import 'package:pizaaelk/model/modifier_model.dart';

class ModifierProvider with ChangeNotifier {
  /// Explore Product
  List<ModifierModel> allModifier = [];
  bool itemsLoading = true;

  StreamSubscription _soldItemsStream;

  Future addModifier(ModifierModel modifier, String uid) async {
    try {
      modifier.uid = uid;
      await Firestore.instance.collection("modifier").add(modifier.toJson());
    } catch (error) {
      print(error);
    }
  }

  void getModifiers() {
    _soldItemsStream = Firestore.instance
        .collection("modifier")
        .orderBy('createAt', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      if (snapshot.documents.length > 0) {
        allModifier.clear();
        snapshot.documents.forEach(
                (element) => allModifier.add(ModifierModel.fromJson(element.data)));
      } else {
        allModifier = [];
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
