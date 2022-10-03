import 'package:flutter/material.dart';

class NoElements extends StatelessWidget {
  const NoElements({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 10),
          const Image(
            height: 100,
            image: AssetImage('assets/milk-icon.png'),
          )
        ],
      ),
    );
  }
}
