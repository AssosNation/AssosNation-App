import 'package:flutter/material.dart';

class FormMainTitle extends StatelessWidget {
  final String title;
  const FormMainTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold),
          ),
          Divider()
        ],
      ),
    );
  }
}
