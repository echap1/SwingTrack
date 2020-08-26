import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class BackgroundVideo extends StatefulWidget {
  @override
  _BackgroundVideoState createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/video_colored_1.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
      });
  }

  @override
  Widget build(BuildContext context) {
    if ((_controller.value.size?.width ?? 0) != 0) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size?.width ?? 0,
            height: _controller.value.size?.height ?? 0,
            child: VideoPlayer(_controller),
          ),
        ),
      );
    } else {
      return VideoPlayer(_controller);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
