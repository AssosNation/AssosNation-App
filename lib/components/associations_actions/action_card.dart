import 'package:assosnation_app/components/action_participation_component.dart';
import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActionCard extends StatelessWidget {
  final AssociationAction action;
  final _userId;

  ActionCard(this.action, this._userId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  "/associationDetails",
                  arguments: this.action.association),
              child: Column(
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
                ActionParticipationComponent(this.action, _userId)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
