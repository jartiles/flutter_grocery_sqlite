import 'package:flutter/material.dart';
//- Provider
import 'package:provider/provider.dart';
import 'package:flutter_grocery_sqlite/providers/grocery_provider.dart';
//- Decoration
import 'package:flutter_grocery_sqlite/ui/input_decoracion.dart';
//- Widgets
import 'package:flutter_grocery_sqlite/widgets/widgets.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryProvider = Provider.of<GroceryProvider>(context);
    final groceryList = groceryProvider.groceriesList;
    final listKey = groceryProvider.listKey;
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
            ? const NoElements(title: 'Don\'t have lists')
            : AnimatedCardList(
                listKey: listKey,
                listItems: groceryList,
                removeList: groceryProvider.deleteGrocery,
              ),
      ),
    );
  }

  //- Create grocery
  showModal(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add a list', textAlign: TextAlign.center),
          children: [
            SimpleDialogOption(
              child: SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _GroceryForm(),
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

class _GroceryForm extends StatelessWidget {
  const _GroceryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryProvider = Provider.of<GroceryProvider>(
      context,
      listen: false,
    );
    final formKey = groceryProvider.formKey;
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => groceryProvider.groceryName = value,
            validator: (value) {
              return value != null && value.length >= 4
                  ? null
                  : 'Incorrect name. Minimum 4 characters';
            },
            decoration: InputDecorartions.inputDecoration(
              hintText: 'Party',
              labelText: 'Add a name to list',
            ),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              final resultValidation = formKey.currentState?.validate();
              if (resultValidation == null || !resultValidation) return;
              await groceryProvider.newGrocery();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
