import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'forms/form_main_title.dart';

class AssociationActionCard extends StatelessWidget {
  final AssociationAction action;

  AssociationActionCard(this.action);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                        child: CircleAvatar(),
                      ),
                      Text(this.action.association.name),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(DateFormat('dd-MM-yyyy').add_Hm().format(
                          DateTime.parse(
                              this.action.startDate.toDate().toString())))
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                FormMainTitle(
                  this.action.title,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                        child: Text(
                          this.action.description,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(
                        Icons.people,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                        '${this.action.usersRegistered != 0 ? this.action.usersRegistered : 'pas'} de participants'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          FireStoreService().addUserToAction(
                              action.association.uid, action.id, 'test');
                        },
                        icon: Icon(Icons.add),
                        label: Text("Je participe")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
