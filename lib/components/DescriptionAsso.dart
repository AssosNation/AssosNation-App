import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionAsso extends StatelessWidget {
  final _descriptionAsso;

  DescriptionAsso(this._descriptionAsso);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _descriptionAsso,
          style: GoogleFonts.varelaRound(
              fontSize: 18.0,
              color: Colors.black54,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
