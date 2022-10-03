import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xFFb4d7dd),
        child: Column(
          children: const [_Background(), _TitleCard()],
        ),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: _titleBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Make your grocery list easy',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Add many lists and products as you want. Your shopping will be much easier',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            FloatingActionButton(
              elevation: 10,
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/grocery_list'),
              backgroundColor: const Color(0xFF24d0b8),
              child: const Icon(Icons.chevron_right, size: 50),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _titleBoxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: const Image(
        height: 300,
        width: 300,
        image: AssetImage('assets/background.png'),
      ),
    );
  }
}
