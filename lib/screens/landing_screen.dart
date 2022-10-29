import 'package:flutter/material.dart';
import 'package:flutter_grocery_sqlite/widgets/grocery/abstract_painter.dart';
import 'package:flutter_grocery_sqlite/providers/providers.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFFb4d7dd),
        child: AbstractPainter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [_Background(), Expanded(child: _TitleCard())],
          ),
        ),
      ),
      floatingActionButtonLocation: screenHeight < 400
          ? FloatingActionButtonLocation.miniEndDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () => validatePreferences(context),
        backgroundColor: const Color(0xFF24d0b8),
        child: const Icon(Icons.chevron_right, size: 50),
      ),
    );
  }

  validatePreferences(BuildContext context) async {
    final showSlide = Preferences.showSlide;
    final route = showSlide ? '/tutorial' : '/grocery_list';
    Navigator.pushReplacementNamed(context, route);
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Make your grocery list easy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Text(
            'Add many lists and products as you want. Your shopping will be much easier',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      height: MediaQuery.of(context).size.height * .6,
      width: 300,
      image: const AssetImage('assets/background.png'),
    );
  }
}
