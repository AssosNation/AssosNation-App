import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeInfoAlert extends StatelessWidget {
  const ChangeInfoAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 50,
      title: Icon(
        Icons.info_outline_rounded,
        color: Colors.teal,
        size: 55,
      ),
      content: Text(
        "If you want to change this information, please contact the support.",
        textAlign: TextAlign.justify,
      ),
      actions: [
        CupertinoButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
