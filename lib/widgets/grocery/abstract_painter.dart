import 'package:flutter/material.dart';

class AbstractPainter extends StatelessWidget {
  AbstractPainter({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ContainerWavesPainter(),
      child: child,
    );
  }
}

class _ContainerWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint();
    painter.style = PaintingStyle.fill;
    painter.color = const Color(0xff4DAFF6);
    painter.strokeWidth = 5;

    final path = Path();
    final widthPath = size.width;
    final heightPath = size.height;

    //- Top shape
    path.lineTo(0, heightPath * 0.3);
    path.quadraticBezierTo(widthPath * 0.20, heightPath * 0.35,
        widthPath * 0.30, heightPath * 0.30);
    path.quadraticBezierTo(widthPath * 0.35, heightPath * 0.22,
        widthPath * 0.60, heightPath * 0.28);
    path.quadraticBezierTo(
        widthPath, heightPath * 0.35, widthPath * 0.80, heightPath * 0.15);
    path.quadraticBezierTo(
        widthPath * 0.70, heightPath * 0.08, widthPath * 0.9, 0);
    canvas.drawPath(path, painter);
    //- Bottom shape
    path.moveTo(widthPath, heightPath);
    path.lineTo(widthPath, heightPath * .7);
    path.quadraticBezierTo(
        widthPath * .75, heightPath * .55, widthPath * .55, heightPath * .75);
    path.quadraticBezierTo(
        widthPath * .45, heightPath * .8, widthPath * .30, heightPath * .80);
    path.quadraticBezierTo(
        widthPath * .12, heightPath * .81, widthPath * .1, heightPath * .85);
    path.quadraticBezierTo(30, heightPath * 0.92, 0, heightPath * .87);
    path.lineTo(0, heightPath);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
