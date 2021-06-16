import 'package:assosnation_app/components/DescriptionAsso.dart';
import 'package:assosnation_app/components/an_bigTitle.dart';
import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationDetails extends StatelessWidget {
  final Association assos;
  AssociationDetails(this.assos);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Association"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        FutureBuilder(
            future: FireStoreService().getAllAssociations(),
            builder: (ctx, AsyncSnapshot<List<Association>> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    return Column(
                      children: [
                        Container(
                          color: Colors.teal,
                          child: AnBigTitle(assos.name),
                          height: 70,
                        ),
                        Image.network(
                          assos.banner,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    );
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                }
              }
              return Container();
            }),
        Container(
          color: Colors.teal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_box),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.message_outlined),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.date_range),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(child: DescriptionAsso(assos.description)),
              SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.location,
                    color: Colors.teal,
                  ),
                  Text(
                    assos.address,
                    style: TextStyle(color: Colors.teal),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_city_rounded,
                    color: Colors.teal,
                  ),
                  Text(
                    assos.city,
                    style: TextStyle(color: Colors.teal),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.phone,
                    color: Colors.teal,
                  ),
                  Text(
                    assos.phone,
                    style: TextStyle(color: Colors.teal),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.teal),
                  Text(
                    assos.president,
                    style: TextStyle(color: Colors.teal),
                  )
                ],
              ),
              Divider(
                thickness: 3,
                indent: 15,
                endIndent: 15,
                color: Colors.teal,
                height: 40,
              ),
              AnTitle("Fil d'actualité"),
            ],
          ),
        ),
      ]),
    );
  }
}
