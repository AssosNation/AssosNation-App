import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnBigTitle extends StatelessWidget {
  final _bigTitle;

  AnBigTitle(this._bigTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _bigTitle,
          style: TextStyle(
              fontSize: 28.0, color: Colors.teal, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
