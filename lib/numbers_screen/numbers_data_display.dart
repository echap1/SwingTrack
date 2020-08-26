import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swing_track/misc/widgets.dart';

final double w = 400;
final double h = 250;

class DataUpdate extends Notification {
  final ShotData data;
  const DataUpdate(this.data);
}

class ShotData {
  double carry = 0;
  double launch = 0;
  double attack = 0;
  double clubSpeed = 0;
  double ballSpeed = 0;
}

TextStyle numbersDisplayDataTextStyle(Brightness brightness) {
  var textColor;

  switch (brightness) {
    case Brightness.dark:
      textColor = Colors.white;
      break;
    case Brightness.light:
      textColor = Colors.black;
      break;
  }

  return TextStyle(
    color: textColor,
    fontSize: 50,
    fontFamily: "DIN Alternate",
    fontWeight: FontWeight.bold
  );
}

TextStyle numbersDisplayUnitsTextStyle = TextStyle(
    color: Colors.green,
    fontSize: 20,
    fontFamily: "DIN Alternate",
    fontWeight: FontWeight.bold
);

class NumbersDataDisplay extends StatelessWidget {
  static final ShotData data = ShotData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Spacer(flex: 3),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Expanded(flex: 50, child: NumbersDataDisplayWidget(data.carry.toStringAsFixed(0), "Carry (yd)")),
                Expanded(flex: 50, child: NumbersDataDisplayWidget(data.launch.toStringAsFixed(1), "Launch Angle (°)")),
                Expanded(flex: 50, child: NumbersDataDisplayWidget(data.attack.toStringAsFixed(1), "Attack Angle (°)")),
                Spacer()
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Expanded(flex: 5, child: NumbersDataDisplayWidget(data.clubSpeed.toStringAsFixed(0), "Club Speed (mph)")),
                Expanded(flex: 5, child: NumbersDataDisplayWidget(data.ballSpeed.toStringAsFixed(0), "Ball Speed (mph)")),
                Spacer()
              ],
            ),
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}

class NumbersDataDisplayWidget extends StatelessWidget {
  final String numberText;
  final String bottomText;

  NumbersDataDisplayWidget(this.numberText, this.bottomText);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NumbersDataDisplayWidgetPainter(numberText, bottomText, Theme.of(context).brightness)
    );
  }
}

class NumbersDataDisplayWidgetPainter extends CustomPainter {
  final String numberText;
  final String bottomText;
  final Brightness brightness;

  NumbersDataDisplayWidgetPainter(this.numberText, this.bottomText, this.brightness);

  @override
  void paint(Canvas canvas, Size size) {
    final double width = min(size.width, size.height * 2.5);
    final double height = size.height;

    double offsetX = (size.width - width) / 2;

    double pX(double percent) => percent * width + offsetX;
    double pY(double percent) => percent * height;

    Offset p1 = Offset(pX(0.1), pY(0.6));

    var unitsTextPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textScaleFactor: height / 110,
        text: TextSpan(
            text: bottomText,
            style: numbersDisplayUnitsTextStyle
        )
    )..layout();

    double oldDx = p1.dx;
    double newDx = min(oldDx, pX(0.70) - unitsTextPainter.width);

    offsetX += (oldDx - newDx) / 2;

    p1 = Offset((newDx + oldDx) / 2, p1.dy);
    Offset p2 = Offset(pX(0.75), pY(0.6));
    Offset p3 = p2 + (Offset(1, -1) * min(pX(0.2), pY(0.2)));

    var dataTextPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaleFactor: height / 110,
      text: TextSpan(
        text: numberText,
        style: numbersDisplayDataTextStyle(brightness)
      )
    )..layout();

    dataTextPainter.paint(canvas, Offset(pX(0.7) - dataTextPainter.width, pY(0.6) - dataTextPainter.height));

    unitsTextPainter.paint(canvas, Offset(pX(0.75) - unitsTextPainter.width, pY(0.62)));

    p1 = Offset(min(p1.dx, pX(0.70) - unitsTextPainter.width), p1.dy);

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4;

    var path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p3.dx, p3.dy);

    paint.style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    var rng = new Random();
    paint.color = Color.fromARGB(255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255));

//    canvas.drawLine(Offset(0, 0), Offset(pX(0), pY(0)), paint);
//    canvas.drawLine(Offset(size.width, size.height), Offset(pX(1), pY(1)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}