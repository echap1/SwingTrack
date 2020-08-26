import 'package:flutter/material.dart';
import 'package:swing_track/home_screen/home_text.dart';
import 'package:flutter/services.dart';

import 'bg_video_player.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
          alignment: AlignmentDirectional.center,
          children: [
//            BackgroundVideo(),
            Material(
              child: HomeText(),
              shadowColor: Colors.transparent,
              color: Colors.transparent,
            )
          ]
      )
    );
  }
}
