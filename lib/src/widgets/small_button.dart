import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final btnText;
  SmallButton({this.btnText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
