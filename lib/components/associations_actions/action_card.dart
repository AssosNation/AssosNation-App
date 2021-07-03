import 'package:assosnation_app/components/action_participation_component.dart';
import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ActionCard extends StatelessWidget {
  final AssociationAction action;
  final _userId;

  ActionCard(this.action, this._userId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        child: Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  "/associationDetails",
                  arguments: this.action.association),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                              imageUrl: action.association.banner,
                            ),
                            Text(this.action.association.name),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Share.share(
                            "${action.association.name} \n ${action.title}\n${action.description}\nPartagé depuis l\'application AssosNation."),
                        icon: Icon(Icons.share),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
            ),
            FormMainTitle(
              this.action.title,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Text(
                    this.action.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.start_date} : ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "${DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.parse(this.action.startDate.toDate().toString()))}",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.end_date} : ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "${DateFormat('dd/MM/yyyy').add_Hm().format(DateTime.parse(this.action.endDate.toDate().toString()))}",
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.address} : ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "${this.action.address}, ${this.action.city} ${this.action.postalCode}",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ActionParticipationComponent(this.action, _userId),
          ],
        ),
      ),
    );
  }
}
