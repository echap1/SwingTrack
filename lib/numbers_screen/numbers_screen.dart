import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:swing_track/numbers_screen/numbers_bottom_buttons.dart';
import 'package:swing_track/numbers_screen/numbers_data_display.dart';
import 'package:swing_track/numbers_screen/numbers_top_buttons.dart';

class NumbersScreen extends StatefulWidget {
  @override
  NumbersScreenState createState() => NumbersScreenState();
}

class NumbersScreenState extends State<NumbersScreen> {
  NumbersDataDisplay dataDisplay = NumbersDataDisplay();
  bool recording = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    var recordButtonReadyForegroundColor = Theme.of(context).brightness == Brightness.dark ?
      Colors.red :
      Colors.red;

    var recordButtonReadyBackgroundColor = Theme.of(context).brightness == Brightness.dark ?
      Color.fromARGB(255, 40, 40, 40) :
      Color.fromARGB(255, 80, 80, 80);


    var recordButtonRecordingForegroundColor = Theme.of(context).brightness == Brightness.dark ?
      Color.fromARGB(255, 200, 200, 200) :
      Color.fromARGB(255, 200, 200, 200);

    var recordButtonRecordingBackgroundColor = Theme.of(context).brightness == Brightness.dark ?
      Color.fromARGB(255, 128, 128, 128) :
      Color.fromARGB(255, 128, 128, 128);


    var recordButtonBackgroundColor = recording ? recordButtonRecordingBackgroundColor : recordButtonReadyBackgroundColor;
    var recordButtonForegroundColor = recording ? recordButtonRecordingForegroundColor : recordButtonReadyForegroundColor;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          accentColor: Colors.green,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          accentColor: Colors.green,
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          body: Material(
            child: Stack(
              alignment: AlignmentDirectional.center,
              fit: StackFit.passthrough,
              children: [
//                  NumbersBottomButtons(),
                NumbersTopButtons(),
                dataDisplay
              ]
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: recordButtonBackgroundColor,
            foregroundColor: recordButtonForegroundColor,
            onPressed: () {setState(() {
              recording = !recording;
              updateShotData((data) => data..carry+=100..attack+=10);
            });},
            child: recording ? Icon(Icons.close) : Icon(Icons.adjust)
          )
        )
    );
  }

  void updateShotData(ShotData updateFunc(ShotData data)) {
    ShotData newData = updateFunc(NumbersDataDisplay.data);
    NumbersDataDisplay.data.carry = newData.carry;
    NumbersDataDisplay.data.ballSpeed = newData.ballSpeed;
    NumbersDataDisplay.data.clubSpeed = newData.clubSpeed;
    NumbersDataDisplay.data.launch = newData.launch;
    NumbersDataDisplay.data.attack = newData.attack;
    dataDisplay = NumbersDataDisplay();
  }
}
