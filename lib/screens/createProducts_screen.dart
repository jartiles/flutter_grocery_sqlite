import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_grocery_sqlite/ui/input_decoracion.dart';

import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/providers/productForm_provider.dart';
import 'package:flutter_grocery_sqlite/providers/product_provider.dart';

class CreateProductsScreen extends StatelessWidget {
  const CreateProductsScreen({Key? key, required this.groceryId})
      : super(key: key);
  final int groceryId;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Form(
              key: formProvider.productsFormKey,
              child: _CreateForm(groceryId: groceryId),
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateForm extends StatelessWidget {
  const _CreateForm({Key? key, required this.groceryId}) : super(key: key);
  final int groceryId;

  unFocusKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<ProductFormProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        const Text('Add a product'),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: formProvider.productName,
          onChanged: (value) => formProvider.productName = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Product name is required';
            }
          },
          decoration: InputDecorartions.inputDecoration(
            hintText: 'Apple',
            labelText: 'Product Name',
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          initialValue: '${formProvider.productPrice}',
          onChanged: (value) {
            if (double.tryParse(value) == null) {
              formProvider.productPrice = 0;
            } else {
              formProvider.productPrice = double.parse(value);
            }
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
          ],
          decoration: InputDecorartions.inputDecoration(
            hintText: '28.00',
            labelText: 'Price per unit',
          ),
        ),
        const SizedBox(height: 20),
        //- Qty buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                unFocusKeyboard(context);
                formProvider.increaseDecrease(false);
              },
              mini: true,
              elevation: 0,
              child: const Icon(Icons.remove),
            ),
            Text(
              '${formProvider.productQty}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            FloatingActionButton(
              onPressed: () {
                unFocusKeyboard(context);
                formProvider.increaseDecrease(true);
              },
              mini: true,
              elevation: 0,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            if (!formProvider.isValidForm()) return;
            await productProvider.createNewProduct(
              name: formProvider.productName,
              price: formProvider.productPrice,
              qty: formProvider.productQty,
              grocery: groceryId,
            );
            formProvider.reset();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(150, 40)),
          child: const Text('Save'),
        )
      ],
    );
  }
}
