import 'package:assosnation_app/components/association_action_card.dart';
import 'package:assosnation_app/components/create_action_dialog.dart';
import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionManagement extends StatelessWidget {
  const ActionManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 2,
          child: Icon(Icons.add),
          onPressed: () => showDialog(
                context: context,
                builder: (context) => CreateActionDialog(_association),
              )),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: _association!.actions!.length,
                itemBuilder: (BuildContext context, int index) {
                  AssociationAction? action = AssociationActionsService()
                      .getAssociationActionFromAssociationInfos(
                          _association, index);
                  if (action != null) {
                    return AssociationActionCard(action);
                  } else {
                    return Text("Vous n'avez pas encore créé d'actions");
                  }
                })),
      ]),
    );
  }
}
