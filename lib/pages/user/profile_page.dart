import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SizedBox(height: 15),
      Text(
        AppLocalizations.of(context)!.title_my_profile,
        style: GoogleFonts.montserrat(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              //TODO : add a Image in the DB for the user to display it here
              backgroundImage: NetworkImage(
                  'https://media-exp1.licdn.com/dms/image/C5603AQEJ5TDmil5VAA/profile-displayphoto-shrink_800_800/0/1522223155450?e=1626307200&v=beta&t=qXIHutBHwCHF9gKoXPP_P6fnvgNvzmUqV5ZOeqDvEiI'),
              radius: 60,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    color: Colors.teal,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Row(children: [
                  Text(
                    "${_user!.firstName} ${_user.lastName}",
                    style: TextStyle(fontSize: 22, color: Colors.teal),
                  ),
                ]),
                Text(
                  _user.mail,
                  style: TextStyle(fontSize: 18, color: Colors.teal),
                ),
              ],
            )
          ],
        ),
      ),
      Divider(
        thickness: 3,
        indent: 15,
        endIndent: 15,
        color: Colors.teal,
        height: 50,
      ),
      AnTitle(AppLocalizations.of(context)!.association_list_label),
      Expanded(
        child: FutureBuilder(
            future: FireStoreService().getSubscribedAssociationsByUser(_user),
            builder: (ctx, AsyncSnapshot<List<Association>> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    List<Association> assosList = snapshot.data!;
                    return Container(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(2),
                            itemCount: assosList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.elliptical(15, 10),
                                        right: Radius.elliptical(10, 15))),
                                elevation: 5,
                                color: Theme.of(context).accentColor,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        "/associationDetails",
                                        arguments: assosList[index]);
                                  },
                                  title: Text(
                                    assosList[index].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(assosList[index].description),
                                ),
                              );
                            }));
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                }
              }
              return Container();
            }),
      ),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  elevation: 50,
                  title: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.redAccent,
                    size: 55,
                  ),
                  content: Text(AppLocalizations.of(context)!.are_you_sure),
                  actions: [
                    CupertinoButton(
                      child: Text(AppLocalizations.of(context)!.yes),
                      onPressed: () {
                        final _auth = FirebaseAuth.instance;
                        _auth.signOut();
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text(
                        AppLocalizations.of(context)!.no,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
          child: Text(
            AppLocalizations.of(context)!.signoff_label,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          )),
    ]);
  }
}
