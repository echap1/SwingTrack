import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:swing_track/numbers_screen/numbers_data_display.dart';
import 'package:swing_track/numbers_screen/numbers_top_buttons.dart';

class ClubNumber {
  static List<String> clubNames = ["PW", "9i", "8i", "7i", "6i", "5i", "4i", "3i", "5w", "3w", "D"];

  int n = 0;

  void increment() {
    n++;
    if (n >= clubNames.length) n = 0;
  }

  void decrement() {
    n--;
    if (n < 0) n = clubNames.length - 1;
  }

  String toString() {
    return clubNames[n];
  }
}

class NumbersScreen extends StatefulWidget {
  static const platform = const MethodChannel('com.ethanchapman.swingtrack/record');
  static final ClubNumber clubNumber = ClubNumber();

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
            onPressed: () async {setState(() {
              recording = !recording;
            });
            int value = await NumbersScreen.platform.invokeMethod("record");
            setState(() {
              NumbersDataDisplay.data.clubSpeed = value.toDouble();
              updateShotData((data) => data);
            });
            },
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
