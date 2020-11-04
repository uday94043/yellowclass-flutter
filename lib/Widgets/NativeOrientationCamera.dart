import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video/Widgets/CameraScreen.dart';

class NativeOrientationCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(builder: (context) {
      NativeDeviceOrientation orientation =
          NativeDeviceOrientationReader.orientation(context);

      int turns;
      switch (orientation) {
        case NativeDeviceOrientation.landscapeLeft:
          turns = -1;
          break;
        case NativeDeviceOrientation.landscapeRight:
          turns = 1;
          break;
        case NativeDeviceOrientation.portraitDown:
          turns = 2;
          break;
        default:
          turns = 0;
          break;
      }

      return RotatedBox(quarterTurns: turns, child: CameraScreen());
    });
  }
}
