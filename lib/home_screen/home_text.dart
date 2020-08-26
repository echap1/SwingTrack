import 'package:flutter/material.dart';
import 'package:swing_track/numbers_screen/numbers_screen.dart';

import 'package:swing_track/misc/widgets.dart';


TextStyle centerTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 60,
    fontFamily: "DIN Alternate",
    fontWeight: FontWeight.bold
);

TextStyle bottomTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: "DIN Alternate",
  fontWeight: FontWeight.bold,
);

Widget _homeTextButton(String text, VoidCallback onPressed) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(text, style: bottomTextStyle),
    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    splashColor: Colors.black45,
    color: Colors.transparent,
    textColor: Colors.white,
    disabledColor: Colors.grey,
    disabledTextColor: Colors.black,
  );
}

class _BottomButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VoidCallback startPracticeSession = () {
      Navigator.pushReplacement(context, FadeRoute(page: NumbersScreen()));
    };

    Widget _bottomButtonRow = Padding(
      child: Row(
          children: [
            Spacer(),
            _homeTextButton("Start Practice Session", startPracticeSession),
            Spacer(),
            _homeTextButton("View Previous Sessions", () {}),
            Spacer()
          ]
      ),
      padding: EdgeInsets.all(10),
    );

    Widget _alignedBottomRow = Align(
        alignment: Alignment.bottomCenter,
        child: _bottomButtonRow
    );

    return _alignedBottomRow;
  }
}

Widget _centerText = Center(
  child: Text(
    "Swing Track Golf",
    style: centerTextStyle,
  ),
);

class HomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _BottomButtonRow(),
        _centerText
      ],
    );
  }
}
