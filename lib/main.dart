
import 'package:bdprogreebar/loaders/color_loader_5.dart';
import 'package:bdprogreebar/loaders/dot_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video/userAuth/PersistUser.dart';
import 'userAuth/SignIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Text("Firebase error"),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: PersistUser(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Center(
              child: ColorLoader5(
                dotOneColor: Colors.red,
                dotTwoColor: Colors.blueAccent,
                dotThreeColor: Colors.green,
                dotType: DotType.circle,
                dotIcon: Icon(Icons.adjust),
                duration: Duration(seconds: 1),
              )),
        );
      },
    );
  }
}



