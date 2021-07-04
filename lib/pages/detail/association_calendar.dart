import 'package:assosnation_app/components/associations_actions/association_action_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
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
                          if (actionList.isNotEmpty) {
                            return Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return AssociationActionCard(
                                      actionList[index]);
                                },
                                itemCount: actionList.length,
                                shrinkWrap: true,
                              ),
                            );
                          } else
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(AppLocalizations.of(context)!
                                  .association_no_actions),
                            );
                        }
                      } else if (snapshot.hasError) {
                        return Text(
                            AppLocalizations.of(context)!.error_no_infos);
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
