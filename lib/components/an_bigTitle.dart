import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnBigTitle extends StatelessWidget {
  final _bigTitle;

  AnBigTitle(this._bigTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          _bigTitle,
          style: GoogleFonts.chewy(fontSize: 35.0, color: Colors.white),
        ),
      ),
    );
  }
}
