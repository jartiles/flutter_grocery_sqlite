import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({
    super.key,
    required this.childrens,
    this.colorActive = Colors.blueAccent,
    this.colorInactive = Colors.grey,
  });
  final List<Map<String, Widget>> childrens;
  final Color colorActive;
  final Color colorInactive;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _SlideModel(),
      child: Builder(
        builder: (context) {
          final slideProvider =
              Provider.of<_SlideModel>(context, listen: false);
          //- Colors
          slideProvider.setAcitveColor = colorActive;
          slideProvider.setInactiveColor = colorInactive;
          //- Content
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const _DontShow(),
                  Expanded(
                    child: _Slides(slides: childrens),
                  ),
                  _Dots(slides: childrens)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DontShow extends StatelessWidget {
  const _DontShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideProvider = Provider.of<_SlideModel>(context, listen: false);
    return TextButton(
      onPressed: () {},
      child: Text(
        'Don\'t show again',
        style: TextStyle(color: slideProvider.getActiveColor),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key, required this.slides}) : super(key: key);
  final List slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      final slideProvider = Provider.of<_SlideModel>(context, listen: false);
      slideProvider.setCurrentPage = pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      children: widget.slides
          .map(
            (slide) => _Slide(
              title: slide['title'],
              element: slide['widget'],
            ),
          )
          .toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({Key? key, required this.title, required this.element})
      : super(key: key);
  final Widget title;
  final Widget element;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: 300,
            child: element,
          ),
          title
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key, required this.slides}) : super(key: key);
  final List slides;

  @override
  Widget build(BuildContext context) {
    final slideProvider = Provider.of<_SlideModel>(context, listen: false);
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              slides.length,
              (index) => _Dot(index: index),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/grocery_list');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: slideProvider.getActiveColor,
            ),
            child: const Text('Go list'),
          )
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final slideProvider = Provider.of<_SlideModel>(context);
    final activeDot = (slideProvider.getCurrentPage - 0.5 <= index &&
        slideProvider.getCurrentPage + 0.5 >= index);
    return Container(
      height: 10,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: activeDot
            ? slideProvider.getActiveColor
            : slideProvider.getInactiveColor,
      ),
    );
  }
}

class _SlideModel extends ChangeNotifier {
  double _currentPage = 0;
  Color _colorActive = Colors.red;
  Color _colorInactive = Colors.grey;
  PageController pageController = PageController();

  //- Pages
  get getCurrentPage => _currentPage;
  set setCurrentPage(double page) {
    _currentPage = page;
    notifyListeners();
  }

  //- Color
  get getActiveColor => _colorActive;
  set setAcitveColor(Color color) {
    _colorActive = color;
  }

  get getInactiveColor => _colorInactive;
  set setInactiveColor(Color color) {
    _colorInactive = color;
  }
}
