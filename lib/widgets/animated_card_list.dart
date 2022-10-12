import 'package:flutter/material.dart';
import 'package:flutter_grocery_sqlite/widgets/grocery/card_grocery.dart';
import 'package:flutter_grocery_sqlite/widgets/products/card_products.dart';

class AnimatedCardList extends StatelessWidget {
  const AnimatedCardList({
    Key? key,
    required this.listKey,
    required this.listItems,
    required this.removeList,
    this.type = 'grocery',
  }) : super(key: key);

  final GlobalKey<AnimatedListState> listKey;
  final List listItems;
  final Function removeList;
  final String? type;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      padding: const EdgeInsets.all(20),
      key: listKey,
      initialItemCount: listItems.length,
      itemBuilder: (context, index, animation) =>
          _buildItem(animation, listItems[index], index),
    );
  }

  SizeTransition _buildItem(Animation<double> animation, item, index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (_) {
          buildRemovedItem(context, animation) => Container();
          removeList(index, item.id);
          listKey.currentState!.removeItem(index, buildRemovedItem);
        },
        child: type == 'grocery'
            ? CardGrocery(grocery: item)
            : CardProducts(product: item),
      ),
    );
  }
}
