import 'package:assosnation_app/components/association_action_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/associationAction.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationCalendar extends StatelessWidget {
  final Association assos;
  AssociationCalendar(this.assos);

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/logo_an.png",
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text(assos.name)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder(
                    future: FireStoreService()
                        .getAllActionsByAssociation(assos, _user!),
                    builder: (context,
                        AsyncSnapshot<List<AssociationAction>> snapshot) {
                      if (snapshot.hasData) {
                        List<AssociationAction> actionList = snapshot.data!;
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return CircularProgressIndicator();
                        else {
                          return Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                if (actionList.isNotEmpty) {
                                  return AssociationActionCard(
                                      actionList[index]);
                                } else {
                                  return Text(
                                      "Aucune action à venir pour cette association ! ");
                                }
                              },
                              itemCount: actionList.length,
                              shrinkWrap: true,
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text("Pas d'actions pour toi l'ami");
                      } else
                        return Container();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
