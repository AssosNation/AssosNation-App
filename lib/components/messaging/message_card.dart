import 'package:assosnation_app/utils/utils.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                sender,
                style: TextStyle(color: Colors.white),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white)),
            ),
            trailing: Text(Utils.getDiffTimeBetweenNowAndTimestamp(timestamp),
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
