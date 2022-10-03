class GroceryModel {
  GroceryModel({
    this.id,
    required this.name,
    this.qty,
    this.qtyComplete,
  });

  int? id;
  String name;
  int? qtyComplete;
  int? qty;

  double get getPercentageTotal {
    if (qty == 0 || qty == null) return 0;
    return qtyComplete! / qty!;
  }

  factory GroceryModel.fromJson(Map<String, dynamic> json) => GroceryModel(
        id: json["id"],
        name: json["name"],
        qtyComplete: json["qtyComplete"] ?? 0,
        qty: json["qty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
