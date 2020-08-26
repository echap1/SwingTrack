import 'package:flutter/material.dart';
import 'package:swing_track/home_screen/home_screen.dart';
import 'package:swing_track/settings_screen/settings_screen.dart';
import 'package:swing_track/misc/widgets.dart';


TextStyle numbersTopButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontFamily: "DIN Alternate",
  fontWeight: FontWeight.bold,
);

Widget _numbersTextButton(String text, VoidCallback onPressed) {
  return RaisedButton(
    onPressed: onPressed,
    child: Text(text, style: numbersTopButtonTextStyle),
    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    splashColor: Colors.grey,
    color: Colors.green,
    disabledColor: Colors.green,
    disabledTextColor: Colors.black,
    elevation: 5,
  );
}


class _TopButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VoidCallback goHome = () {
      Navigator.pushReplacement(context,FadeRoute(page: HomeScreen()));
    };


    VoidCallback goSettings = () {
      Navigator.push(context, FadeRoute(page: SettingsScreen()));
    };

    Widget _topButtonRow = Material(
      color: Theme.of(context).brightness == Brightness.light ?
        Color.fromARGB(255, 180, 180, 180) :
        Color.fromARGB(255, 20, 20, 20),
      child: Padding(
        child: Row(
            children: [
              Spacer(),
              _numbersTextButton("End Session", goHome),
              Spacer(flex: 9),
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      child: Icon(Icons.add, color: Colors.white),
                      backgroundColor: Colors.green
                    ),
                    Text('PW', style: new TextStyle(fontSize: 25.0)),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {},
                      child: Icon(Icons.remove, color: Colors.white),
                      backgroundColor: Colors.green
                    ),
                  ],
                ),
              ),
              Spacer(flex: 9),
              SizedBox(
                height: 35,
                child: FloatingActionButton(
                    heroTag: null,
                    onPressed: goSettings,
                    child: Icon(Icons.settings, color: Colors.white),
                    backgroundColor: Colors.green
                ),
              ),
              Spacer()
            ]
        ),
        padding: EdgeInsets.all(8),
      )
    );

    Widget _alignedBottomRow = Align(
        alignment: Alignment.topCenter,
        child: _topButtonRow
    );

    return _alignedBottomRow;
  }
}

class NumbersTopButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.passthrough,
      children: [
        _TopButtonRow()
      ],
    );
  }
}
