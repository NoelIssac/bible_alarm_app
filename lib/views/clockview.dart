import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({Key key, this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override void initState() {
    // This override is to animate the clock .
    // Calling setstate automatically triggers the state change acc to the time
    // which is by the second here
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container (
      width: widget.size,
      height: widget.size,
      // transform below by 90 deg anticlockwise as canvas starts with the opp side
        // pi /2 is 90 deg and to specify it as anticlockwise do it as -pi/2
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  // 60 sec -> 360 deg so 1 sec 6 deg

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);

    var radius =  min(centerX, centerY);

    var fillBrush = Paint()
      ..color = Color(0xFF444974);
    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
    ..strokeWidth = size.width / 20;

    var centerFillBrush = Paint()
      ..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[400]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 60;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.lightGreen])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 30;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 24;

    canvas.drawCircle(center, radius * .75, fillBrush); // Blue color circle
    canvas.drawCircle(center, radius * .75, outlineBrush); // outline circle circle

    // for each hour the hour hand moves 30 deg so for watch minute lets move it by .5 deg
    var houHandX = centerX + radius * 0.4 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/ 180);
    var houHandY = centerY + radius * 0.4 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/ 180);
    canvas.drawLine(center, Offset(houHandX, houHandY), hourHandBrush);

    var minHandX = centerX + radius * 0.6 * cos(dateTime.minute * 6 * pi/ 180);
    var minHandY = centerY + radius * 0.6 * sin(dateTime.minute * 6 * pi/ 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    //var secHandX = centerX + 80 * cos(90 * pi/ 180);
    //var secHandY = centerY + 80 * sin(90 * pi/ 180);
    var secHandX = centerX + radius * 0.6 * cos(dateTime.second * 6 * pi/ 180);
    var secHandY = centerY + radius * 0.6 * sin(dateTime.second * 6 * pi/ 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush); // center dot

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    var outerCircleRad = radius;
    var innerCircleRad = radius * 0.9;
    for(double i=0; i<360; i+=12) {
      var x1 = centerX + outerCircleRad * cos(i * pi / 180);
      var y1 = centerY + outerCircleRad * sin(i * pi / 180);

      var x2 = centerX + innerCircleRad * cos(i * pi / 180);
      var y2 = centerY + innerCircleRad * sin(i * pi / 180);
      canvas.drawLine(Offset(x1,y1), Offset(x2,y2), dashBrush);
    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
