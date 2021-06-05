import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final sender;
  final content;
  final timestamp;
  final bool senderIsLocalUser;

  MessageCard(
      this.sender, this.content, this.timestamp, this.senderIsLocalUser);

  _converTimestampToDateTime() {
    final DateTime time = timestamp.toDate();
    return "${time.hour}h${time.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      color: senderIsLocalUser ? Theme.of(context).accentColor : Colors.grey,
      child: ListTile(
        title: Text(
          sender,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(content,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: Text(_converTimestampToDateTime(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
