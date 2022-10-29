import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_grocery_sqlite/widgets/widgets.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShow(
        colorActive: const Color(0xff4DAFF6),
        colorInactive: Colors.grey,
        childrens: [
          {
            'title': Text(
              'Create a shopping list with just a title',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            'widget': SvgPicture.asset(
              'assets/slides/add_list.svg',
              fit: BoxFit.contain,
            )
          },
          {
            'title': Text(
              'Add products to that list. With a name, price and quantity to buy',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            'widget': SvgPicture.asset(
              'assets/slides/products.svg',
              fit: BoxFit.contain,
            )
          },
          {
            'title': Text(
              'When purchasing the product click on the check box to subtract it from the total.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            'widget': SvgPicture.asset(
              'assets/slides/add_list.svg',
              fit: BoxFit.contain,
            )
          },
          {
            'title': Text(
              'Delete any item from your lists swiping to left or right',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            'widget': SvgPicture.asset(
              'assets/slides/swip.svg',
              fit: BoxFit.contain,
            )
          },
        ],
      ),
    );
  }
}
