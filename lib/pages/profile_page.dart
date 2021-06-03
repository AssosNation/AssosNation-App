import 'package:assosnation_app/components/an_title.dart';
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
      Container(
          height: 200.0,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: associations.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('Asso ${associations[index]}')),
                );
              }))
    ]);
  }
}
