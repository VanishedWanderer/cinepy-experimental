import 'package:flutter/material.dart';

class FilmPainter extends CustomPainter{
  const FilmPainter({
    @required this.rectColor,
    this.cornerRadius = 5
  }): super();

  final Color rectColor;
  final double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    var rectSize = size.height;
    var padding = rectSize/2;
    var intervalSize = rectSize + 2*padding;
    var rectCount = size.width / intervalSize;

    var rectPaint = Paint();
    rectPaint.color = rectColor;

    for(int i = 0; i < rectCount; i++){
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(
          center: Offset((i+0.5)*intervalSize, size.height/2),
          width: rectSize, height: rectSize
      ), Radius.circular(cornerRadius)), rectPaint);
    }
  }
  @override
  bool shouldRepaint(FilmPainter oldDelegate) {
    return oldDelegate.rectColor != rectColor || oldDelegate.cornerRadius != cornerRadius;
  }
}
