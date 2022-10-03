import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//- Theme
import 'package:flutter_grocery_sqlite/theme/custom_theme.dart';
//- Provider
import 'package:flutter_grocery_sqlite/providers/grocery_provider.dart';
//- Model
import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/models/grocery_model.dart';
import 'package:flutter_grocery_sqlite/providers/product_provider.dart';

class CardGrocery extends StatelessWidget {
  const CardGrocery({Key? key, required this.grocery}) : super(key: key);
  final GroceryModel grocery;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: CustomTheme.cardStyle,
      child: Column(
        children: [
          _GroceryHeader(grocery: grocery),
          LinearProgressIndicator(
            value: grocery.getPercentageTotal,
            backgroundColor: const Color(0xFFb8b7b7),
          ),
          _GroceryFooter(grocery: grocery)
        ],
      ),
    );
  }
}

class _GroceryFooter extends StatelessWidget {
  const _GroceryFooter({Key? key, required this.grocery}) : super(key: key);
  final GroceryModel grocery;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
          height: 25,
          width: 25,
          child: RawMaterialButton(
            shape: const CircleBorder(),
            fillColor: CustomTheme.primary,
            child: const Icon(Icons.add, size: 16, color: Colors.white),
            onPressed: () async {
              final productService =
                  Provider.of<ProductProvider>(context, listen: false);
              productService.loadProducts(grocery.id!);
              Navigator.pushNamed(
                context,
                '/products_list',
                arguments: grocery,
              );
            },
          ),
        ),
        Text('Add products', style: Theme.of(context).textTheme.caption)
      ],
    );
  }
}

class _GroceryHeader extends StatelessWidget {
  const _GroceryHeader({Key? key, required this.grocery}) : super(key: key);
  final GroceryModel grocery;

  @override
  Widget build(BuildContext context) {
    final groceryProvider =
        Provider.of<GroceryProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          grocery.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
        ),
        Row(
          children: [
            Text(
              '${grocery.qtyComplete}/${grocery.qty}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4294cf),
              ),
            ),
            SizedBox(
              width: 20,
              height: 40,
              child: SpeedDial(
                icon: Icons.more_vert,
                iconTheme: const IconThemeData(size: 50.0, color: Colors.grey),
                activeIcon: Icons.close,
                elevation: 0,
                backgroundColor: Colors.transparent,
                curve: Curves.bounceInOut,
                direction: SpeedDialDirection.left,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.delete, color: Colors.red),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onTap: () async {
                      await groceryProvider.deleteGrocery(grocery.id!);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.create, color: Colors.green),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onTap: () => print('Pressed Read Later'),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
