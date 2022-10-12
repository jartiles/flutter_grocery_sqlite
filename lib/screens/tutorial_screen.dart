import 'package:flutter/material.dart';
import 'package:flutter_grocery_sqlite/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              'Agrega una lista de compras solo con el titulo',
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
              'Agregar productos a tu lista',
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
              'Resta tu producto del total con el check',
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
              'Elimina tu lista o productos haciendo swipe horizontal',
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
