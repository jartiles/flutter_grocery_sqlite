// To parse this JSON data, do
//
//     final groceryModel = groceryModelFromJson(jsonString);

import 'dart:convert';

ProductModel groceryModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String groceryModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.complete,
    required this.grocery_id,
  });

  int? id;
  final String name;
  final String price;
  final int qty;
  int complete;
  final int grocery_id;

  set setComplete(bool value) {
    if (value) {
      complete = 1;
    }
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        complete: json["complete"],
        grocery_id: json["grocery_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "qty": qty,
        "complete": complete,
        "grocery_id": grocery_id,
      };
}
