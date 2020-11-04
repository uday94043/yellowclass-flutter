import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  Widget textFormField;
  Field(this.textFormField);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 25.0, right: 25.0, top: 40.0),
      child: Container(
        height: 53.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 6.0,
                color: Colors.black12.withOpacity(0.05),
                spreadRadius: 1.0)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 5.0),
          child: Theme(
            data: ThemeData(
                hintColor: Colors.transparent),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 10.0),
              child: textFormField
            ),
          ),
        ),
      ),
    );
  }
}
