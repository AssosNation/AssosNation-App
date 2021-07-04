import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Column(
      children: [
        AnTitle("${AppLocalizations.of(context)!.user_tab_messaging}"),
        Expanded(
          child: StreamBuilder(
            stream: MessagingService().watchAllConversationsByUser(_user!),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final List<Conversation> convs =
                    Converters.convertDocSnapshotsToConvList(
                        snapshot.data!.docs);
                if (convs.length > 0) {
                  return ListView.builder(
                    itemCount: convs.length,
                    clipBehavior: Clip.antiAlias,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.elliptical(15, 10),
                                  right: Radius.elliptical(10, 15))),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed("/convAsUser",
                                  arguments: convs[index]);
                            },
                            trailing: convs[index].messages.length > 0
                                ? Text(
                                    "${convs[index].getDiffTimeBetweenNowAndLastMessage()}")
                                : Text(""),
                            title: Text(convs[index].names[1]),
                            subtitle: Row(
                              children: [
                                Text("${convs[index].getLastMessageSender()}"),
                                Expanded(
                                  child: Text(
                                    convs[index].getLastMessageSent(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                              'Aucune conversation n\'a été commencée.\nPour commencer une conversation, allez sur le détail d\'une association et commencez une conversation.',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor)),
                        )
                      ]);
                }
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
