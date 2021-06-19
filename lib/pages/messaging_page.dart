import 'package:assosnation_app/services/messaging/messaging_service.dart';
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
                          leading: CircleAvatar(
                            child: Text(
                                "${snapshots.data![index].title.substring(0, 1)}"),
                          ),
                          title: Text(snapshots.data![index].title),
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
                              "${snapshots.data![index].getDiffTimeBetweenNowAndLastMessage()} h"),
                          onTap: () {
                            Navigator.of(context).pushNamed("/conversation",
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
