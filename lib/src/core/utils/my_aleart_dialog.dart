import 'package:bazaro_cs/src/core/widgets/submit_button.dart';
import 'package:flutter/material.dart';

void myAleartDialog(BuildContext context, {String text = ''}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          SubmitButton(
          
            text: 'ok',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
