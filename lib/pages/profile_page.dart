import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO : change this list with the associations of the user connected
    final List<String> associations = <String>['1', '2', '3'];
    final List<int> colorCodes = <int>[600, 500, 100];

    final _user = context.watch<AnUser?>();

    if (_user != null)
      FireStoreService().getSubscribedAssociationByUser(_user.uid);

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            //TODO : add a Image in the DB for the user to display it here
            backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C5603AQEJ5TDmil5VAA/profile-displayphoto-shrink_800_800/0/1522223155450?e=1626307200&v=beta&t=qXIHutBHwCHF9gKoXPP_P6fnvgNvzmUqV5ZOeqDvEiI'),
            radius: 60,
          ),
          Column(
            children: [
              Row(children: [
                AnTitle(_user!.firstName),
                AnTitle(_user.lastName)
              ]),
              AnTitle(_user.mail)
            ],
          )
        ],
      ),
      AnTitle("Mes associations"),
      Flexible(
        flex: 1,
        child: FutureBuilder(
            future:
                FireStoreService().getSubscribedAssociationByUser(_user.uid),
            builder: (ctx, AsyncSnapshot<List<Association>> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    List<Association> assosList = snapshot.data!;
                    return Container(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: assosList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Theme.of(context).accentColor,
                                child: ListTile(
                                  title: Text(assosList[index].name),
                                  subtitle: Text(assosList[index].description),
                                ),
                              );
                            }));
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                }
              }
              return Container();
            }),
      ),
    ]);
  }
}
