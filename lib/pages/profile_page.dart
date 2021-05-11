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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            //TODO : add a Image in the DB for the user to display it here
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
            radius: 60,
          ),
          AnTitle(_user!.mail),
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
