import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/description_asso.dart';
import 'package:assosnation_app/components/dialog/association_informations_dialog.dart';
import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationDetails extends StatelessWidget {
  final Association assos;

  AssociationDetails(this.assos);

  _navigateToConversation(BuildContext context, String userId) async {
    final result =
        await MessagingService().initConversationIfNotFound(userId, assos.uid);
    if (result is Conversation) {
      print("RESULT => $result");
      Navigator.pop(context);
      Navigator.of(context).pushNamed("/convAsUser", arguments: result);
    } else
      Utils.displaySnackBarWithMessage(
          context, result.toString(), Colors.deepOrange);
  }

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Scaffold(
      appBar: AppBar(
        title: Text(assos.name),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            children: [
              Image.network(
                assos.banner,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          Container(
            color: Colors.teal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        if (_user != null) {
                          if (assos.didUserSubscribed(_user.uid)) {
                            FireStoreService()
                                .unsubscribeToAssociation(assos.uid, _user.uid);
                            Utils.displaySnackBarWithMessage(
                                context,
                                "Vous n'êtes plus abonné à cette association ! ",
                                Colors.deepOrange);
                          } else {
                            FireStoreService()
                                .subscribeToAssociation(assos.uid, _user.uid);
                            Utils.displaySnackBarWithMessage(
                                context,
                                "Vous êtes désormais abonné à cette association !",
                                Colors.green);
                          }
                        }
                      },
                      icon: Icon(assos.didUserSubscribed(_user!.uid)
                          ? Icons.remove_circle
                          : Icons.add_circle),
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(Icons.message_outlined),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: _navigateToConversation(context, "_user.uid")),
                IconButton(
                    icon: Icon(Icons.date_range),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () => Navigator.of(context).pushNamed(
                        "/associationCalendarPage",
                        arguments: assos)),
                IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return AssociationInformationsDialog(assos: assos);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(child: DescriptionAsso(assos.description)),
                SizedBox(height: 10),
                Divider(
                  thickness: 3,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.teal,
                  height: 40,
                ),
                AnTitle("News Feed"),
              ],
            ),
          ),
          FutureBuilder(
            future: PostService().retrieveAllPostsForAssociation(assos),
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    List<Post> postList = snapshot.data!;
                    if (postList.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NewsFeedCard(postList[index], '', _user.uid);
                        },
                        itemCount: postList.length,
                      );
                    } else
                      return Text(
                          "${assos.name} n'a pas encore publié son premier post ! ");
                }
              }
              if (snapshot.hasError) {
                return Container(
                  child: Text("Something wrong happened"),
                );
              }
              return Container();
            },
          ),
        ]),
      ),
    );
  }
}
