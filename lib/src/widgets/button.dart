import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  Button({this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.blueAccent),
      child: Center(
        child: Text(
          "$buttonText",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
