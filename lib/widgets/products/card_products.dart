import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/providers/product_provider.dart';

import 'package:flutter_grocery_sqlite/models/product_model.dart';

class CardProducts extends StatelessWidget {
  const CardProducts({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    return Container(
      color: product.complete == 1 ? null : Colors.white,
      child: ListTile(
        leading: Checkbox(
          value: product.complete == 1,
          onChanged: (value) async {
            await productsProvider.updateProductStatus(value, product);
          },
        ),
        title: Text(product.name, style: const TextStyle(fontSize: 16)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${product.qty}', style: Theme.of(context).textTheme.caption),
            const SizedBox(width: 30),
            Text('\$${product.price}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
