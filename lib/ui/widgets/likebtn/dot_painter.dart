import 'package:flutter/material.dart';

class DotPainter extends CustomPainter {
  final int dotCount;

  double outerDotsPositionAngle = 51.42;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  double centerX = 0.0;
  double centerY = 0.0;
  final List<Paint> circlePaints = List(4);
  double maxOuterDotsRadius = 0.0;
  double maxInnerDotsRadius = 0.0;
  double maxDotSize;
  final currentProgress;
  double currentRadius1 = 0.0;
  double currentDotSize1 = 0.0;
  double currentDotSize2 = 0.0;
  double currentRadius2 = 0.0;
  bool isFirst = true;

  DotPainter(
      {this.dotCount = 7,
      this.color1 = const Color(0xFFFFC107),
      this.color2 = const Color(0xFFFF9800),
      this.color3 = const Color(0xFFFF5722),
      this.color4 = const Color(0xFFF44336),
      @required this.currentProgress}) {
    outerDotsPositionAngle = 360.0 / dotCount;
    for (int i = 0; i < circlePaints.length; i++) {
      circlePaints[i] = new Paint()..style = PaintingStyle.fill;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isFirst) {
      centerX = size.width * 0.5;
      centerY = size.height * 0.5;
      maxDotSize = size.width * 0.05;
      maxOuterDotsRadius = size.width * 0.5 - maxDotSize * 2;
      maxInnerDotsRadius = size.width * 0.5 - maxDotSize * 2;
      isFirst = false;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return null;
  }
}
