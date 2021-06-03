import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnTitle extends StatelessWidget {
  final _title;

  AnTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Row(
          children: [
            Text(
              _title,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
