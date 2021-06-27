import 'package:assosnation_app/components/messaging/message_card.dart';
import 'package:assosnation_app/components/messaging/send_message_form.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationConvPage extends StatelessWidget {
  final Conversation conversation;

  AssociationConvPage({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.names
            .firstWhere((name) => name != _association!.name)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 10,
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
                        return ListView.builder(
                          itemCount: conversation.messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: conversation
                                          .messages[index]["sender"].id ==
                                      _association!.uid
                                  ? MessageCard(
                                      "${_association.name}",
                                      conversation.messages[index]["content"],
                                      conversation.messages[index]["timestamp"],
                                      true)
                                  : MessageCard(
                                      conversation.names.firstWhere((name) =>
                                          name != "${_association.name}"),
                                      conversation.messages[index]["content"],
                                      conversation.messages[index]["timestamp"],
                                      false),
                            );
                          },
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
              SendMessageForm(conversation.uid,
                  conversation.getDocRefWithId(_association!.uid)),
            ],
          )
        ],
      ),
    );
  }
}
