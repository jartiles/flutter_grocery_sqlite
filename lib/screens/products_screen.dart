import 'package:flutter/material.dart';

import 'package:flutter_grocery_sqlite/screens/screens.dart';
import 'package:flutter_grocery_sqlite/theme/custom_theme.dart';
import 'package:flutter_grocery_sqlite/models/grocery_model.dart';
import 'package:flutter_grocery_sqlite/widgets/widgets.dart';

import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/providers/product_provider.dart';
import 'package:flutter_grocery_sqlite/providers/grocery_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  showCreateProduct(BuildContext context, int grocery) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => CreateProductsScreen(groceryId: grocery),
    );
  }

  late GroceryProvider _myProvider;

  @override
  void initState() {
    super.initState();
    _myProvider = Provider.of<GroceryProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _myProvider.getGroceries();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GroceryModel args =
        ModalRoute.of(context)?.settings.arguments as GroceryModel;
    final productsProvider = Provider.of<ProductProvider>(context);
    final products = productsProvider.currentProducts;
    final listKey = productsProvider.listKey;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showCreateProduct(context, args.id!),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: products.isEmpty
                ? const NoElements(title: 'Don\'t have products')
                : AnimatedCardList(
                    listItems: products,
                    listKey: listKey,
                    removeList: productsProvider.deleteProduct,
                    type: 'product',
                  ),
          ),
          const Expanded(child: _TotalPrices()),
        ],
      ),
    );
  }
}

class _TotalPrices extends StatelessWidget {
  const _TotalPrices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: CustomTheme.cardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Unchecked',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '\$${productsProvider.totalUnchecked}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Total',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '\$${productsProvider.total}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Image(
            image: AssetImage('assets/milk-icon.png'),
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
