import 'package:flutter/material.dart';

class FormSubTitle extends StatelessWidget {
  final String title;
  const FormSubTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
