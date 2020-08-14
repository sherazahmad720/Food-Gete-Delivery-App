import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  CustomListTile({this.icon, this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
