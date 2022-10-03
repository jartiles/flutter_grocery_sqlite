import 'package:flutter/material.dart';
//- DB
import 'package:flutter_grocery_sqlite/providers/db_provider.dart';
//- Models
import 'package:flutter_grocery_sqlite/models/grocery_model.dart';

class GroceryProvider extends ChangeNotifier {
  String groceryName = '';
  bool isLoading = false;
  List<GroceryModel> groceriesList = [];

  GroceryProvider() {
    getGroceries();
  }

  Future newGrocery() async {
    isLoading = true;
    notifyListeners();
    final newGrocery = GroceryModel(name: groceryName, qty: 0, qtyComplete: 0);
    final id = await DbProvider.db.insertNewGrocery(newGrocery);
    newGrocery.id = id;
    groceriesList.add(newGrocery);
    isLoading = false;
    notifyListeners();
    return newGrocery;
  }

  Future getGroceries() async {
    final groceries = await DbProvider.db.getAllGroceries();
    groceriesList = [...groceries];
    notifyListeners();
  }

  Future deleteGrocery(int id) async {
    await DbProvider.db.deleteGrocery(id);
    final index = groceriesList.indexWhere((grocery) => grocery.id == id);
    if (index != -1) {
      groceriesList.removeAt(index);
      notifyListeners();
    }
  }
}
