import 'package:assosnation_app/components/messaging/send_message_card.dart';
import 'package:assosnation_app/components/messaging/send_message_form.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation Title"),
        backwardsCompatibility: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Theme.of(context).accentColor,
                    child: SendMessageCard(),
                  ),
                );
              },
            ),
          ),
          Expanded(flex: 1, child: SendMessageForm()),
        ],
      ),
    );
  }
}
