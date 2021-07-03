import 'package:assosnation_app/components/description_asso.dart';
import 'package:assosnation_app/components/dialog/change_infos_alert.dart';
import 'package:assosnation_app/components/dialog/edit_association_img_dialog.dart';
import 'package:assosnation_app/components/edit_asso_dialog.dart';
import 'package:assosnation_app/services/firebase/firestore/association_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationPage extends StatelessWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _assosAuth = context.watch<Association?>();

    return SingleChildScrollView(
      child: StreamBuilder<DocumentSnapshot>(
          stream: AssociationService().watchAssociationInfo(_assosAuth!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.active) {
                final Association _association =
                    Converters.convertDocSnapshotsToAssos(snapshot.data!);
                return Stack(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => EditAssociationImgDialog(
                                association: _association),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 2)),
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 0.7,
                                  child: Image.network(
                                    _association.banner,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Theme.of(context).accentColor,
                                    size: 45,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DescriptionAsso(_association.description),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.teal),
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                EditAssoDialog(_association, "description"),
                          ),
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.home_filled,
                                  color: Theme.of(context).accentColor),
                              title: Text(
                                  AppLocalizations.of(context)!
                                      .association_name_label,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(
                                _association.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit, color: Colors.teal),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      EditAssoDialog(_association, "name"),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Theme.of(context).accentColor),
                              title: Text(AppLocalizations.of(context)!.phone,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(_association.phone,
                                  style: Theme.of(context).textTheme.subtitle1),
                              trailing: IconButton(
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context).accentColor),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      EditAssoDialog(_association, "phone"),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.home_filled,
                                  color: Theme.of(context).accentColor),
                              title: Text(AppLocalizations.of(context)!.address,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(_association.address,
                                  style: Theme.of(context).textTheme.subtitle1),
                              trailing: IconButton(
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context).accentColor),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      EditAssoDialog(_association, "address"),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.location_city_sharp,
                                  color: Theme.of(context).accentColor),
                              title: Text(AppLocalizations.of(context)!.city,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(_association.city,
                                  style: Theme.of(context).textTheme.subtitle1),
                              trailing: IconButton(
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context).accentColor),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      EditAssoDialog(_association, "city"),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.mail_outline_sharp,
                                  color: Theme.of(context).accentColor),
                              title: Text(AppLocalizations.of(context)!.mail,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(_association.mail,
                                  style: Theme.of(context).textTheme.subtitle1),
                              trailing: IconButton(
                                icon: Icon(Icons.info_outline,
                                    color: Colors.grey),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => ChangeInfoAlert(),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.person_outline_sharp,
                                  color: Theme.of(context).accentColor),
                              title: Text(
                                  AppLocalizations.of(context)!.president,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2),
                              subtitle: Text(_association.president,
                                  style: Theme.of(context).textTheme.subtitle1),
                              trailing: IconButton(
                                icon: Icon(Icons.info_outline,
                                    color: Colors.grey),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => ChangeInfoAlert(),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              } else
                return CircularProgressIndicator();
            } else
              return Container();
          }),
    );
  }
}
