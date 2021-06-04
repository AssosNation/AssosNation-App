import 'package:assosnation_app/components/messaging/send_message_form.dart';
import 'package:assosnation_app/services/messaging/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatelessWidget {
  final Conversation conversation;
  ConversationPage({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: MessagingService()
                  .getAllMessagesByConversation(conversation.uid),
              builder: (BuildContext build, AsyncSnapshot snapshots) {
                if (snapshots.hasData) {
                  switch (snapshots.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      return ListView.builder(
                        itemCount: snapshots.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Container(
                                child: Text("msg"),
                              ),
                            ),
                          );
                        },
                      );
                    case ConnectionState.none:
                      return Container();
                      break;
                    case ConnectionState.active:
                      return CircularProgressIndicator();
                  }
                }
                if (snapshots.hasError) return Container();
                return Container();
              },
            ),
          ),
          Expanded(flex: 1, child: SendMessageForm()),
        ],
      ),
    );
  }
}
