import 'package:assosnation_app/components/an_title.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
            radius: 60,
          ),
          AnTitle("tester@test.fr"),
        ],
      ),
      AnTitle("Mes associations"),
      Container(
          height: 200.0,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.greenAccent,
                child: const Center(child: Text('Association A')),
              ),
              Container(
                height: 50,
                color: Colors.greenAccent,
                child: const Center(child: Text('Association B')),
              ),
              Container(
                height: 50,
                color: Colors.greenAccent,
                child: const Center(child: Text('Association C')),
              ),
            ],
          ))
    ]);
  }
}
