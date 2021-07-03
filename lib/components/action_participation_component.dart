import 'package:assosnation_app/services/firebase/firestore/user_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
      widget._action.usersRegistered =
          widget._action.usersRegistered + (participateAction ? 1 : -1);
      widget._action.isUserRegistered = participateAction;
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
              Text((widget._action.usersRegistered > 0
                      ? this.widget._action.usersRegistered.toString()
                      : 'pas de') +
                  ' participant' +
                  (widget._action.usersRegistered > 1 ? 's' : '')),
            ],
          ),
        ),
        TextButton.icon(
            onPressed: () {
              Share.share(
                  '${widget._action.title}\n${widget._action.description}\nPartagé depuis l\'application AssosNation.');
            },
            icon: Icon(Icons.share),
            label: Text('')),
        TextButton.icon(
            onPressed: () {
              if (widget._action.isUserRegistered) {
                UserService()
                    .removeUserToAction(widget._action, widget._userId);
                updateState(false);
              } else {
                UserService().addUserToAction(widget._action, widget._userId);
                updateState(true);
              }
            },
            icon: Icon(widget._action.isUserRegistered
                ? Icons.add_circle_outlined
                : Icons.add_circle_outline),
            label: Text(widget._action.isUserRegistered
                ? AppLocalizations.of(context)!.registered_to_events_label
                : AppLocalizations.of(context)!.participate_button_label)),
      ],
    );
  }
}
