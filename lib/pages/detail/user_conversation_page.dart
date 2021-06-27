import 'package:assosnation_app/components/messaging/message_card.dart';
import 'package:assosnation_app/components/messaging/send_message_form.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
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
        title: FutureBuilder(
          future: conversation.getReceiverName(_user!.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.done)
                return Text(snapshot.data);
              if (snapshot.connectionState == ConnectionState.waiting)
                return LinearProgressIndicator();
            }
            return Text("Une erreur est survenue");
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: MessagingService()
                  .getAllMessagesByConversation(conversation.uid),
              builder: (BuildContext build, AsyncSnapshot<List> snapshots) {
                if (snapshots.hasData) {
                  switch (snapshots.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      return ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: snapshots.data![index].sender.id ==
                                      _user.uid
                                  ? MessageCard(
                                      "${_user.firstName} ${_user.lastName}",
                                      snapshots.data![index].content,
                                      snapshots.data![index].timestamp,
                                      true)
                                  : MessageCard(
                                      conversation.names.firstWhere((name) =>
                                          name !=
                                          "${_user.firstName} ${_user.lastName}"),
                                      snapshots.data![index].content,
                                      snapshots.data![index].timestamp,
                                      false),
                            ),
                          );
                        },
                      );
                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.active:
                      return CircularProgressIndicator();
                  }
                }
                if (snapshots.hasError) return Container();
                return Container();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SendMessageForm(
                conversation.uid, conversation.getDocRefWithId(_user.uid)),
          )
        ],
      ),
    );
  }
}
