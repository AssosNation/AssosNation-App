import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("$index"),
                ),
                title: Text("Conversation Name"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Last sender : "),
                    Expanded(
                      child: Text(
                        "Last message sent",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                trailing: Text("$index h"),
                onTap: () {
                  Navigator.of(context).pushNamed("/conversation");
                },
              ),
            );
          },
        ))
      ],
    );
  }
}
