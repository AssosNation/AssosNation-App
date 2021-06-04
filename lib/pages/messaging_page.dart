import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
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
          future: FireStoreService().getAllConversationsByUser(_user),
          builder: (BuildContext build, AsyncSnapshot snapshots) {
            if (snapshots.hasData) {
              switch (snapshots.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: snapshots.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("$index"),
                          ),
                          title: Text(snapshots.data[index].title),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Last sender : "),
                              Expanded(
                                child: Text(
                                  "Last message sent",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text("$index h"),
                          onTap: () {
                            Navigator.of(context).pushNamed("/conversation",
                                arguments: snapshots.data[index]);
                          },
                        ),
                      );
                    },
                  );
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
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
