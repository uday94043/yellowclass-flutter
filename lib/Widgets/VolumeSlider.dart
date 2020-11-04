
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VolumeSlider extends StatefulWidget {
  VideoPlayerController _controller;

  VolumeSlider(controller){
    this._controller = controller;
  }

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _position;
  VideoPlayerController _controller;

  @override
  void initState() {
  super.initState();
   _position = 0.5;
   _controller = widget._controller;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.volume_up_rounded,
        size: 30.0,
        color: Colors.black,),
        Slider(
        min: 0.0,
        max: 1.0,
        activeColor: Colors.black,
        inactiveColor: Color(0xFF5C5C6E),
        onChanged: (v) {
          _controller.setVolume(v.toDouble());
          setState(() {
            _position = v.toDouble();
          });
        },
        value: (_position != null && _position > 0 && _position <= 1.0
            ? _position
            : 0.0),
      ),]
    );
  }
}
