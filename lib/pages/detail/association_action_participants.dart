import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';

class AssociationActionParticipants extends StatelessWidget {
  final AssociationAction action;

  AssociationActionParticipants(this.action);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(action.title),
        ),
        body: FutureBuilder<List<AnUser>>(
          future: AssociationActionsService().getParticipants(action),
          builder: (context, AsyncSnapshot<List<AnUser>> snapshot) {
            if (snapshot.hasData) {
              final List<AnUser> userList = snapshot.data!;
              String url = '';
              userList.forEach((user) {
                url += '${user.mail};';
              });
              return Column(
                children: [
                  TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.teal)))),
                      onPressed: () async => {
                            await canLaunch('mailto:$url')
                                ? await launch('mailto:$url')
                                : print("Not launched")
                          },
                      child: Text(
                        'Envoyer un message à tous les participants',
                        style: TextStyle(fontSize: 15),
                      )),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ActionParticipantInfos(userList[index]);
                    },
                    itemCount: userList.length,
                    shrinkWrap: true,
                  ),
                ],
              );
            } else
              return Container(
                  padding: const EdgeInsets.all(150),
                  child: CircularProgressIndicator());
          },
        ));
  }
}

class ActionParticipantInfos extends StatelessWidget {
  final AnUser user;

  ActionParticipantInfos(this.user);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${user.firstName} ${user.lastName![0]}'),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () async => {
              await canLaunch('mailto:${user.mail}')
                  ? await launch('mailto:${user.mail}')
                  : print("Not launched")
            },
          )
        ],
      ),
    );
  }
}
