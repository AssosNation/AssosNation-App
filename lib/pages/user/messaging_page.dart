import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
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
            child: FutureBuilder(
          future: MessagingService().getAllConversationsByUser(_user!.uid),
          builder: (BuildContext build,
              AsyncSnapshot<List<Conversation>> snapshots) {
            if (snapshots.hasData) {
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
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
        ))
      ],
    );
  }
}
