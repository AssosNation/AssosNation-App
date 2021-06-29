import 'package:assosnation_app/components/an_big_title.dart';
import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/description_asso.dart';
import 'package:assosnation_app/components/edit_asso_dialog.dart';
import 'package:assosnation_app/services/firebase/firestore/association_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/converters.dart';
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          color: Colors.teal,
                          child: AnBigTitle(_association.name),
                        ),
                        Image.network(
                          _association.banner,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: AnTitle("My association's informations")),
                        Divider(
                          thickness: 3,
                          indent: 15,
                          endIndent: 15,
                          color: Colors.teal,
                          height: 30,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                            child: DescriptionAsso(_association.description)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.teal),
                              onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    EditAssoDialog(_association, "description"),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.home_filled, color: Colors.teal),
                              Text("Name : ${_association.name}"),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.teal),
                                onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      EditAssoDialog(_association, "name"),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.phone, color: Colors.teal),
                              Text("Phone number : ${_association.phone}"),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.teal),
                                  onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (context) => EditAssoDialog(
                                            _association, "phone"),
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.home_filled, color: Colors.teal),
                              Text("Adress : ${_association.address}"),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.teal),
                                  onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (context) => EditAssoDialog(
                                            _association, "address"),
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.location_city, color: Colors.teal),
                              Text("City : ${_association.city}"),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.teal),
                                  onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (context) => EditAssoDialog(
                                            _association, "city"),
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.mail, color: Colors.teal),
                              Text("E-Mail : ${_association.mail}"),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 50,
                                            title: Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.teal,
                                              size: 55,
                                            ),
                                            content: Text(
                                                "If you want to change this information, please contact the support."),
                                            actions: [
                                              CupertinoButton(
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  })
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.teal),
                              Text("Director : ${_association.president}"),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 50,
                                            title: Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.teal,
                                              size: 55,
                                            ),
                                            content: Text(
                                                "If you want to change this information, please contact the support."),
                                            actions: [
                                              CupertinoButton(
                                                child: Text("Ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  })
                            ],
                          ),
                        ),
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
