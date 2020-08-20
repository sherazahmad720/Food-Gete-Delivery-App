import 'package:flutter/material.dart';

Future<void> showLoadingIndicator(BuildContext context, String message) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(message)
            ],
          ),
        );
      });
}
