import 'package:assosnation_app/components/an_bigTitle.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    if (_user != null)
      FireStoreService().getSubscribedAssociationsByUser(_user.uid);

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      FutureBuilder(
          future:
              FireStoreService().getSubscribedAssociationsByUser(_user!.uid),
          builder: (ctx, AsyncSnapshot<List<Association>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  return Column(
                    children: [
                      SizedBox(height: 30),
                      AnBigTitle(snapshot.data![0].name),
                      SizedBox(height: 40),
                      Image.network(snapshot.data![0].banner)
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
    ]);
  }
}
