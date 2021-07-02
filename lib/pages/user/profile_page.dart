import 'dart:io';

import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl =
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.cnetfrance.fr%2Fnews%2Fa-15h-la-premiere-image-d-un-trou-noir-pourrait-changer-notre-perception-de-l-univers-39883293.htm&psig=AOvVaw03O2KXB1-G6GVNGYAAL7Dt&ust=1625251631664000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCLiR76TEwvECFQAAAAAdAAAAABAD";
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      SizedBox(height: 15),
      Text(
        AppLocalizations.of(context)!.title_my_profile,
        style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
      ),
      Container(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Positioned(
                  top: 120,
                  left: 120,
                  child: IconButton(
                    iconSize: 25,
                    onPressed: () {
                      uploadImage(_user!);
                    },
                    icon: Icon(Icons.add_a_photo),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 66,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "${_user!.firstName}",
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
                Text(
                  "${_user.lastName}",
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
                Text(
                  _user.mail,
                  style: TextStyle(
                      fontSize: 15, color: Theme.of(context).primaryColor),
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
        color: Theme.of(context).primaryColor,
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

  uploadImage(AnUser user) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('users_images/${user.uid}')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
