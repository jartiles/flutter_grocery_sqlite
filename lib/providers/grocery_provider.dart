import 'package:flutter/material.dart';
//- DB
import 'package:flutter_grocery_sqlite/providers/db_provider.dart';
//- Models
import 'package:flutter_grocery_sqlite/models/grocery_model.dart';

class GroceryProvider extends ChangeNotifier {
  String groceryName = '';
  bool isLoading = false;
  List<GroceryModel> groceriesList = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  GroceryProvider() {
    getGroceries();
  }

  Future newGrocery() async {
    final newGrocery = GroceryModel(name: groceryName, qty: 0, qtyComplete: 0);
    final id = await DbProvider.db.insertNewGrocery(newGrocery);
    newGrocery.id = id;
    groceriesList.add(newGrocery);
    if (listKey.currentState != null) {
      final length = groceriesList.isEmpty ? 0 : groceriesList.length - 1;
      listKey.currentState!.insertItem(length);
    }
    notifyListeners();
    return newGrocery;
  }

  Future getGroceries() async {
    final groceries = await DbProvider.db.getAllGroceries();
    groceriesList = [...groceries];
    notifyListeners();
  }

  Future deleteGrocery(int index, int id) async {
    await DbProvider.db.deleteGrocery(id);
    groceriesList.removeAt(index);
    notifyListeners();
  }
}
