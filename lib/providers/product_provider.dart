import 'package:flutter/cupertino.dart';

import 'package:flutter_grocery_sqlite/models/product_model.dart';

import 'db_provider.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> currentProducts = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  double get totalUnchecked {
    if (currentProducts.isEmpty) return 0.0;
    Iterable<ProductModel> unchecked =
        currentProducts.where((element) => element.complete == 0);
    return unchecked.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.qty * double.parse(element.price)),
    );
  }

  double get total {
    if (currentProducts.isEmpty) return 0.0;
    return currentProducts.fold(
      0,
      (previousValue, element) =>
          previousValue + (element.qty * double.parse(element.price)),
    );
  }

  Future createNewProduct({
    required String name,
    required double price,
    required int qty,
    required int grocery,
  }) async {
    final newProduct = ProductModel(
      name: name,
      price: price.toString(),
      qty: qty,
      complete: 0,
      grocery_id: grocery,
    );
    final id = await DbProvider.db.insertNewProduct(newProduct);
    newProduct.id = id;
    currentProducts.add(newProduct);
    if (listKey.currentState != null) {
      final length = currentProducts.isEmpty ? 0 : currentProducts.length - 1;
      listKey.currentState!.insertItem(length);
    }
    notifyListeners();
  }

  Future loadProducts(int grocery) async {
    currentProducts.clear();
    final products = await DbProvider.db.getAllProductsByGrocery(grocery);
    currentProducts = [...products];
    notifyListeners();
  }

  Future updateProductStatus(bool? complete, ProductModel productUpdate) async {
    final index = currentProducts.indexWhere(
      (product) => product.id == productUpdate.id,
    );
    if (index > -1) {
      if (complete!) {
        currentProducts[index].complete = 1;
      } else {
        currentProducts[index].complete = 0;
      }
      await DbProvider.db.updateProductStatus(currentProducts[index]);
      notifyListeners();
    }
  }

  Future deleteProduct(int index, int id) async {
    await DbProvider.db.deleteProduct(id);
    currentProducts.removeAt(index);
    notifyListeners();
  }
}
