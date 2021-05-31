import 'package:flutter/material.dart';

class SendMessageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cardColor = Theme.of(context).accentColor;

    return Card(
      child: ListTile(
        title: Text("Message"),
        subtitle: Text("timestamp"),
      ),
    );
  }
}
