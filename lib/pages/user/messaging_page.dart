import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/converters.dart';
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
        Expanded(
          child: StreamBuilder(
            stream: MessagingService().watchAllConversationsByUser(_user!),
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
                            Navigator.of(context).pushNamed("/convAsUser",
                                arguments: convs[index]);
                          },
                          trailing: Text(
                              "${convs[index].getDiffTimeBetweenNowAndLastMessage()}"),
                          title: FutureBuilder(
                            future: convs[index].getReceiverName(_user.uid),
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
/*
StreamBuilder(
          stream: MessagingService().watchAllConversationsByUser(_user!),
          builder:
              (BuildContext build, AsyncSnapshot<QuerySnapshot> snapshots) {
            final List<Conversation> convs =
                Converters.convertDocSnapshotsToConvList(snapshots.data!.docs);
            if (snapshots.hasData) {
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.elliptical(15, 10),
                                right: Radius.elliptical(10, 15))),
                        child: ListTile(
                          title: FutureBuilder(
                            future: snapshots.data![index]
                                .getReceiverName(_user.uid),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: snapshots.data![index]
                                    .getLastMessageSenderAsync(),
                                initialData: "",
                                builder: (context, snapshot) =>
                                    Text("${snapshot.data} : "),
                              ),
                              Expanded(
                                child: Text(
                                  snapshots.data![index].getLastMessageSent(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                              "${snapshots.data![index].getDiffTimeBetweenNowAndLastMessage()}"),
                          onTap: () {
                            Navigator.of(context).pushNamed("/convAsUser",
                                arguments: snapshots.data![index]);
                          },
                        ),
                      );
                    },
                  );
                case ConnectionState.none:
                  return Container();
                case ConnectionState.active:
                  break;
              }
            }
            if (snapshots.hasError) return Container();
            return Container();
          },
        )
 */
