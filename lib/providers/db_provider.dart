import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
//- Models
import 'package:flutter_grocery_sqlite/models/grocery_model.dart';
import 'package:flutter_grocery_sqlite/models/product_model.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider();

  Future<Database> get getDatabase async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'GroceryDB.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Groceries(id INTEGER PRIMARY KEY,name TEXT)',
        );
        await db.execute('''
          CREATE TABLE Products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            price TEXT,
            qty INTEGER,
            complete INTEGER,
            grocery_id INTEGER,
            FOREIGN KEY(grocery_id) REFERENCES Groceries(id)
          )
        ''');
      },
    );
  }

  Future<int> insertNewGrocery(GroceryModel newGrocery) async {
    final db = await getDatabase;
    final res = await db.insert('Groceries', newGrocery.toJson());
    return res;
  }

  Future<int> deleteGrocery(int id) async {
    final db = await getDatabase;
    final res = await db.delete('Groceries', where: 'id = ?', whereArgs: [id]);
    await db.delete('Products', where: 'grocery_id = ?', whereArgs: [id]);
    return res;
  }

  Future getAllGroceries() async {
    final db = await getDatabase;
    final res = await db.rawQuery('''
        SELECT *,
        (SELECT COUNT(*) FROM Products WHERE Products.grocery_id = Groceries.id AND Products.complete = 1)
        AS qtyComplete,
        (SELECT COUNT(*) FROM Products WHERE Products.grocery_id = Groceries.id)
        AS qty
        FROM Groceries
    ''');
    return res.isEmpty
        ? []
        : res.map((grocery) => GroceryModel.fromJson(grocery)).toList();
  }

  //- Products
  Future<int> insertNewProduct(ProductModel newProduct) async {
    final db = await getDatabase;
    final res = await db.insert('Products', newProduct.toJson());
    return res;
  }

  Future getAllProductsByGrocery(int grocery) async {
    final db = await getDatabase;
    final res = await db
        .query('Products', where: 'grocery_id = ?', whereArgs: [grocery]);
    return res.isEmpty
        ? []
        : res.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future updateProductStatus(ProductModel productUpdate) async {
    final db = await getDatabase;
    final res = await db.update('Products', productUpdate.toJson(),
        where: 'id = ?', whereArgs: [productUpdate.id]);
    print(res);
    return res;
  }
}
