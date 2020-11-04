import 'package:video/Widgets/VolumeSlider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'Widgets/NativeOrientationCamera.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  bool _displayControls;
  double bottom;
  double right;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _displayControls = false;
    _controller.setLooping(true);
    bottom = 10.0;
    right = 10.0;
  }

  Widget dragItem() {
    return Container(
      constraints: BoxConstraints(maxHeight: 180.0, maxWidth: 180.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: NativeOrientationCamera(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _displayControls = _displayControls ? false : true;
            });
          },
          child: Center(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
        ),
        Positioned(
          bottom: 100.0,
          left: 30.0,
          child: Container(
            child: _displayControls ? VolumeSlider(_controller) : null,
          ),
        ),
        Draggable(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: bottom, right: right),
            child: dragItem(),
          ),
          feedback: Container(),
          onDragEnd: (drag) {
            setState(() {
              bottom =
                  bottom - drag.offset.dy < 0 ? 0 : bottom - drag.offset.dy;
              right = right - drag.offset.dx < 0 ? 0 : right - drag.offset.dx;
            });
          },
        ),
      ]),
      floatingActionButton: _displayControls
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
