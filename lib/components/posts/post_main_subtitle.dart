import 'package:flutter/material.dart';

class PostMainSubtitle extends StatelessWidget {
  final String textValue;

  const PostMainSubtitle(this.textValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textValue,
        maxLines: 1,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14),
      ),
    );
  }
}
