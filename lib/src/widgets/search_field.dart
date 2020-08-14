import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search any food",
            contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            suffixIcon: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
