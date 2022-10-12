import 'package:flutter/material.dart';

class NoElements extends StatefulWidget {
  const NoElements({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NoElements> createState() => _NoElementsState();
}

class _NoElementsState extends State<NoElements>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _animation = Tween(begin: Offset.zero, end: const Offset(0, 0.1))
        .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 10),
          SlideTransition(
              position: _animation,
              child: const Image(
                height: 100,
                image: AssetImage('assets/milk-icon.png'),
              ))
        ],
      ),
    );
  }
}
