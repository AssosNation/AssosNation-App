import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionAsso extends StatelessWidget {
  final _descriptionAsso;

  DescriptionAsso(this._descriptionAsso);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _descriptionAsso,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
