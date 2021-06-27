import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationMessagingPage extends StatelessWidget {
  const AssociationMessagingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream:
                MessagingService().watchAllConversationsByAssos(_association!),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final List<Conversation> convs =
                    Converters.convertDocSnapshotsToConvList(
                        snapshot.data!.docs);
                return ListView.builder(
                  itemCount: convs.length,
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
                            Navigator.of(context).pushNamed(
                                "/convAsAssociation",
                                arguments: convs[index]);
                          },
                          trailing: Text(
                              "${convs[index].getDiffTimeBetweenNowAndLastMessage()}"),
                          title: FutureBuilder(
                            future:
                                convs[index].getReceiverName(_association.uid),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done)
                                  return Text(snapshot.data);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return LinearProgressIndicator();
                              }
                              return Text("Une erreur est survenue");
                            },
                          ),
                          subtitle: Row(
                            children: [
                              FutureBuilder(
                                future:
                                    convs[index].getLastMessageSenderAsync(),
                                initialData: "",
                                builder: (context, snapshot) =>
                                    Text("${snapshot.data} : "),
                              ),
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
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
