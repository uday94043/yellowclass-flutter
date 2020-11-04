import 'package:bdprogreebar/loaders/color_loader_5.dart';
import 'package:bdprogreebar/loaders/dot_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../VideoApp.dart';
import 'SignIn.dart';

class PersistUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        SharedPreferences prefs = snapshot.data;

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done &&
            prefs?.getBool('isLoggedIn') == true) {
          return MaterialApp(
            home: VideoApp(),
          );
        }
        return MaterialApp(
          home: SignIn(),
        );
      },
    );
  }
}
