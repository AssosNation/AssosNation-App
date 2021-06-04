import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    FireStoreService().getAllConversationsByUser(_user);
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
                          title: Text("Conversation Name"),
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
                            Navigator.of(context).pushNamed("/conversation");
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

/*
ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("$index"),
                ),
                title: Text("Conversation Name"),
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
                  Navigator.of(context).pushNamed("/conversation");
                },
              ),
            );
          },
        )
 */
