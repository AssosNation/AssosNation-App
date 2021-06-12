import 'package:assosnation_app/services/models/associationAction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      Text(this.action.association.name)
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
                        Icons.thumb_up,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(''),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_up_alt_outlined),
                        label: Text("Like")),
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
