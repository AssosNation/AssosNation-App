import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forms/form_main_title.dart';

class ActionParticipationComponent extends StatefulWidget {
  final AssociationAction _action;
  final _userId;
  ActionParticipationComponent(this._action, this._userId);

  @override
  _ActionParticipationComponentState createState() =>
      _ActionParticipationComponentState();
}

class _ActionParticipationComponentState
    extends State<ActionParticipationComponent> {
  updateState(participateAction) {
    setState(() {
      this.widget._action.usersRegistered =
          this.widget._action.usersRegistered + (participateAction ? 1 : -1);
      this.widget._action.isUserRegistered = participateAction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.people,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text((this.widget._action.usersRegistered > 0
                      ? this.widget._action.usersRegistered.toString()
                      : 'pas de') +
                  ' participant' +
                  (this.widget._action.usersRegistered > 1 ? 's' : '')),
            ],
          ),
        ),
        TextButton.icon(
            onPressed: () {
              if (this.widget._action.isUserRegistered) {
                FireStoreService()
                    .removeUserToAction(widget._action, this.widget._userId);
                updateState(false);
              } else {
                FireStoreService()
                    .addUserToAction(widget._action, this.widget._userId);
                updateState(true);
              }
            },
            icon: Icon(this.widget._action.isUserRegistered
                ? Icons.add_circle_outlined
                : Icons.add_circle_outline),
            label: Text(this.widget._action.isUserRegistered
                ? "Inscrit !"
                : "Je participe")),
      ],
    );
  }
}
