import 'package:bdprogreebar/loaders/color_loader_5.dart';
import 'package:bdprogreebar/loaders/dot_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/VideoApp.dart';
import 'package:video/Widgets/Field.dart';
import 'package:video/Constants.dart';

import 'SignUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  _SignInState();

  bool isLoading = false;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _id;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: ColorLoader5(
              dotOneColor: Colors.red,
              dotTwoColor: Colors.blueAccent,
              dotThreeColor: Colors.green,
              dotType: DotType.circle,
              dotIcon: Icon(Icons.adjust),
              duration: Duration(seconds: 1),
            ))
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Container(
                      height: _height,
                      width: double.infinity,
                      child: Form(
                        key: _registerFormKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0),
                            ),
                            Field(TextFormField(
                              onSaved: (input) => _email = input,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              autofocus: false,
                              decoration: textDecorationConstant("Email"),
                            )),
                            Field(TextFormField(
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return 'Please type a password';
                                  }
                                  return "";
                                },
                                onSaved: (input) => _pass = input,
                                style: new TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                autofocus: false,
                                obscureText: true,
                                decoration:
                                    textDecorationConstant("Password"))),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 64.0),
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences prefs;
                                  prefs = await SharedPreferences.getInstance();
                                  final formState =
                                      _registerFormKey.currentState;
                                  UserCredential user;
                                  formState.save();
                                  try {
                                    prefs.setString("username", _email);
                                    prefs.setString("id", _id);
                                    prefs.setBool("isLoggedIn", false);
                                    user = await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: _email,
                                      password: _pass,
                                    );

                                    setState(() {
                                      isLoading = true;
                                    });
                                    // user.sendEmailVerification();

                                  } catch (e) {
                                    print('Error: $e');
                                    CircularProgressIndicator();
                                    print(e.message);
                                    print(_email);

                                    print(_pass);
                                  } finally {
                                    if (user != null) {
                                      user = await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                            email: _email,
                                            password: _pass,
                                          )
                                          .then((currentUser) =>
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(currentUser.user.uid)
                                                  .get()
                                                  .then((DocumentSnapshot
                                                      result) {
                                                prefs.setBool(
                                                    "isLoggedIn", true);
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        PageRouteBuilder(
                                                            pageBuilder: (_, __,
                                                                    ___) =>
                                                                VideoApp()));
                                              }).catchError(
                                                      (err) => print(err)))
                                          .catchError((err) => print(err));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Login Failed"),
                                              content: Text(
                                                  "Please check your password and try again!"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Close"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 52.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFEC5D57),
                                      Color(0xFFFF942F),
                                    ]),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Signin",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Sofia",
                                        letterSpacing: 0.9),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            new SignUp()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0),
                                  ),
                                  Text(" Signup",
                                      style: TextStyle(
                                          fontFamily: "Sofia",
                                          color: Color(0xFFEC5D57),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.0))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
