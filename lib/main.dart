import 'package:flutter/material.dart';

import 'package:flutter_grocery_sqlite/providers/grocery_provider.dart';
import 'package:flutter_grocery_sqlite/providers/productForm_provider.dart';
import 'package:flutter_grocery_sqlite/providers/product_provider.dart';

import 'package:flutter_grocery_sqlite/screens/screens.dart';
import 'package:flutter_grocery_sqlite/theme/custom_theme.dart';
//- Provider
import 'package:provider/provider.dart';

void main() => runApp(MyProvider());

class MyProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GroceryProvider()),
        ChangeNotifierProvider(create: (context) => ProductFormProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery List',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme().customTheme,
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/grocery_list': (context) => const GroceryScreen(),
        '/products_list': (context) => const ProductsScreen(),
      },
    );
  }
}
