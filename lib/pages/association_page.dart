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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.add_box),
              color: Colors.lightGreen,
              iconSize: 30,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.message_outlined),
              color: Colors.lightGreen,
              iconSize: 30,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.date_range),
              color: Colors.lightGreen,
              iconSize: 30,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.lightGreen,
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ]),
    );
  }
}
