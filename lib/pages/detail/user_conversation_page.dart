import 'package:assosnation_app/components/messaging/message_card.dart';
import 'package:assosnation_app/components/messaging/send_message_form.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserConvPage extends StatelessWidget {
  final Conversation conversation;

  UserConvPage({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.names.firstWhere(
            (name) => name != "${_user!.firstName} ${_user.lastName}")),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: MessagingService()
                      .watchConversationById(conversation.uid),
                  builder: (BuildContext build,
                      AsyncSnapshot<DocumentSnapshot> snapshots) {
                    if (snapshots.hasData) {
                      if (snapshots.connectionState == ConnectionState.active) {
                        final convInfos = Converters.convertDocSnapshotsToConv(
                            snapshots.data!);
                        conversation.messages = convInfos.messages;
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.1),
                          child: ListView.builder(
                            itemCount: conversation.messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: conversation
                                            .messages[index]["sender"].id ==
                                        _user!.uid
                                    ? MessageCard(
                                        "${_user.firstName} ${_user.lastName}",
                                        conversation.messages[index]["content"],
                                        conversation.messages[index]
                                            ["timestamp"],
                                        true)
                                    : MessageCard(
                                        conversation.names.firstWhere((name) =>
                                            name !=
                                            "${_user.firstName} ${_user.lastName}"),
                                        conversation.messages[index]["content"],
                                        conversation.messages[index]
                                            ["timestamp"],
                                        false),
                              );
                            },
                          ),
                        );
                      } else if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                    }
                    if (snapshots.hasError) return CircularProgressIndicator();
                    return Container();
                  },
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SendMessageForm(
                  conversation.uid, conversation.getDocRefWithId(_user!.uid)),
            ],
          )
        ],
      ),
    );
  }
}
