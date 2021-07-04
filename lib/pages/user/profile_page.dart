import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/dialog/are_you_sure_dialog.dart';
import 'package:assosnation_app/components/gamification_xpbar.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/firestore/gamification_service.dart';
import 'package:assosnation_app/services/firebase/firestore/user_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/gamification.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _first = true;
  @override
  Widget build(BuildContext context) {
    AnUser? _user = context.watch<AnUser?>();

    return StreamBuilder<DocumentSnapshot>(
        stream: UserService().watchUserInfos(_user!),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.active) {
              final streamUser =
                  Converters.convertDocSnapshotsToUser(snapshot.data!);
              _user = streamUser;
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      AppLocalizations.of(context)!.title_my_profile,
                      style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                                  onPressed: () async {
                                    await StorageService()
                                        .uploadAndUpdateUserImage(_user!);
                                  },
                                  icon: Icon(Icons.add_a_photo),
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor:
                                      Theme.of(context).accentColor,
                                  child: CachedNetworkImage(
                                    imageUrl: _user!.profileImg,
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        backgroundImage: imageProvider,
                                        radius: 66,
                                      );
                                    },
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
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                "${_user!.lastName}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                _user!.mail,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: GamificationService()
                            .getGamificationInfos(_user!.gamificationRef.id),
                        builder: (ctx, AsyncSnapshot<Gamification> snapshot) {
                          if (snapshot.hasData) {
                            Gamification gamification = snapshot.data!;
                            return Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => {_first = !_first});
                                          },
                                          child: AnimatedCrossFade(
                                              firstChild: Text(
                                                  'Niveau : ${gamification.level}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              secondChild: Text(
                                                  'Il te manque ${Constants.xpToLevelMultiplier - (gamification.exp % Constants.xpToLevelMultiplier)} points d\'xp\n'
                                                  'pour atteindre le niveau ${gamification.level + 1}',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              crossFadeState: _first
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                              duration: const Duration(
                                                  milliseconds: 500)),
                                        ),
                                      ]),
                                  GamificationXpBar(
                                      level: gamification.level,
                                      exp: gamification.exp),
                                ],
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    AnTitle(
                        AppLocalizations.of(context)!.association_list_label),
                    Expanded(
                      child: FutureBuilder(
                          future: FireStoreService()
                              .getSubscribedAssociationsByUser(_user!),
                          builder:
                              (ctx, AsyncSnapshot<List<Association>> snapshot) {
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              color: Colors.teal[300],
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/associationDetails",
                                                          arguments:
                                                              assosList[index]);
                                                },
                                                title: Text(
                                                  assosList[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  assosList[index].description,
                                                ),
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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AreYouSureDialog();
                            },
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signoff_label,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        )),
                  ]);
            } else
              return CircularProgressIndicator();
          } else
            return Container();
        });
  }
}
