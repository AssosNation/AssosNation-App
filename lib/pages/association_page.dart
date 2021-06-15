import 'package:assosnation_app/components/DescriptionAsso.dart';
import 'package:assosnation_app/components/an_bigTitle.dart';
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
        title: Text(assos.name),
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
                        SizedBox(height: 20),
                        AnBigTitle(assos.name),
                        SizedBox(height: 30),
                        Image.network(
                          assos.banner,
                          width: MediaQuery.of(context).size.width,
                        )
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
        SizedBox(height: 10),
        Container(
          color: Colors.teal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add_box),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {},
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
        SizedBox(height: 20),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.location),
                  Text(assos.address),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_city_rounded),
                  Text(assos.city),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Icon(CupertinoIcons.phone), Text(assos.phone)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.person_alt_circle),
                  Text(assos.president)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        DescriptionAsso(assos.description),
      ]),
    );
  }
}
