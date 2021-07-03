import 'package:assosnation_app/components/associations_actions/association_action_card.dart';
import 'package:assosnation_app/components/associations_actions/create_action_dialog.dart';
import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/firebase/firestore/association_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionManagement extends StatelessWidget {
  const ActionManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _assos = context.watch<Association?>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: Text(
              AppLocalizations.of(context)!.events_management_main_title,
              style: Theme.of(context).textTheme.headline3),
        ),
        Expanded(
          child: StreamBuilder(
            stream: AssociationService().watchAssociationInfo(_assos!),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.data != null) {
                final Association _association =
                    Converters.convertDocSnapshotsToAssos(snapshot.data!);

                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return Scaffold(
                      floatingActionButton: FloatingActionButton(
                          elevation: 2,
                          child: Icon(Icons.add),
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    CreateActionDialog(_association),
                              )),
                      body: Column(children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: _association.actions!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  AssociationAction? action =
                                      AssociationActionsService()
                                          .getAssociationActionFromAssociationInfos(
                                              _association, index);
                                  if (action != null) {
                                    return AssociationActionCard(action);
                                  } else {
                                    return Text(AppLocalizations.of(context)!
                                        .no_actions_available);
                                  }
                                })),
                      ]),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                } else {
                  return Container();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }
}
