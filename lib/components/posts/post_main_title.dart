import 'package:flutter/material.dart';

class PostMainTitle extends StatelessWidget {
  final String textValue;

  const PostMainTitle(this.textValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textValue,
        maxLines: 1,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18),
      ),
    );
  }
}
