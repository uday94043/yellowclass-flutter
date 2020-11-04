import 'package:bdprogreebar/loaders/color_loader_5.dart';
import 'package:bdprogreebar/loaders/dot_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/Constants.dart';
import 'package:video/Widgets/Field.dart';

import 'SignIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _SignUpState();

  bool isLoading = false;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String _email, _pass, _name;

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
                              "Create Account",
                              style: TextStyle(
                                  fontFamily: "Sofia",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28.0),
                            ),
                            Field(TextFormField(
                                onSaved: (input) => _name = input,
                                style: new TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                autofocus: false,
                                decoration:
                                    textDecorationConstant("Username"))),
                            Field(TextFormField(
                                onSaved: (input) => _email = input,
                                style: new TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                autofocus: false,
                                decoration: textDecorationConstant("Email"))),
                            Field(TextFormField(
                                validator: (input) {
                                  if (input.length < 8) {
                                    return 'atleast 8 characters';
                                  }
                                },
                                onSaved: (input) => _pass = input,
                                style: new TextStyle(color: Colors.black),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                obscureText: true,
                                autofocus: false,
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
                                  if (formState.validate()) {
                                    formState.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      prefs.setString("username", _name);
                                      prefs.setString("email", _email);
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _email.trim(),
                                              password: _pass)
                                          .then((currentUser) =>
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(currentUser.user.uid)
                                                  .set({
                                                    "uid": currentUser.user.uid,
                                                    "name": _name,
                                                    "email": _email,
                                                    "password": _pass,
                                                  })
                                                  .then((result) => {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          PageRouteBuilder(
                                                              pageBuilder: (_,
                                                                      __,
                                                                      ___) =>
                                                                  SignIn()),
                                                        )
                                                      })
                                                  .catchError(
                                                      (err) => print(err)))
                                          .catchError((err) => print(err));
                                    } catch (e) {
                                      print(e.message);
                                      print(_email);
                                      print(_pass);
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
                                    "Signup",
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
                                        pageBuilder: (_, __, ___) => SignIn()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Have an account?",
                                    style: TextStyle(
                                        fontFamily: "Sofia",
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.0),
                                  ),
                                  Text(" Signin",
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
