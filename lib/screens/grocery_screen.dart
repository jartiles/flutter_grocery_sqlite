import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/providers/grocery_provider.dart';

import 'package:flutter_grocery_sqlite/ui/input_decoracion.dart';

import 'package:flutter_grocery_sqlite/widgets/widgets.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryProvider = Provider.of<GroceryProvider>(context);
    final groceryList = groceryProvider.groceriesList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My lists'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showModal(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => groceryProvider.getGroceries(),
        child: groceryList.isEmpty
            ? const NoElements(title: 'Dont have lists yet')
            : ListView.builder(
                itemCount: groceryList.length,
                itemBuilder: (context, index) =>
                    CardGrocery(grocery: groceryList[index]),
                padding: const EdgeInsets.all(20),
              ),
      ),
    );
  }

  showModal(BuildContext context) {
    final groceryProvider =
        Provider.of<GroceryProvider>(context, listen: false);
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add a list', textAlign: TextAlign.center),
          children: [
            SimpleDialogOption(
              child: SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onChanged: (value) => groceryProvider.groceryName = value,
                      validator: (value) {
                        return value != null && value.length > 4
                            ? null
                            : 'Nombre incorrecto';
                      },
                      decoration: InputDecorartions.inputDecoration(
                        hintText: 'Party',
                        labelText: 'Add a name to list',
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () async {
                        await groceryProvider.newGrocery();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
