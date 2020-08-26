import 'package:flutter/material.dart';
import 'package:swing_track/home_screen/home_screen.dart';
import 'package:swing_track/misc/widgets.dart';


TextStyle buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: "DIN Alternate",
  fontWeight: FontWeight.bold,
);


Widget _numbersTextButton(String text, VoidCallback onPressed) {
  return RaisedButton(
    onPressed: onPressed,
    child: Text(text, style: buttonTextStyle),
    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    splashColor: Colors.grey,
    color: Colors.green,
    disabledColor: Colors.green,
    disabledTextColor: Colors.black,
    elevation: 5,
  );
}


class _BottomButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VoidCallback goHome = () {
      Navigator.pushReplacement(context,FadeRoute(page: HomeScreen()));
    };

    Widget _bottomButtonRow = Padding(
      child: Row(
          children: [
            Spacer(),
            _numbersTextButton("Play Video", goHome),
            Spacer(),
            _numbersTextButton("Save Video", () {}),
            Spacer(flex: 9)
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

class NumbersBottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _BottomButtonRow()
      ],
    );
  }
}
