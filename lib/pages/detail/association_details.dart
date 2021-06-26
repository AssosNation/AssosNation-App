import 'package:assosnation_app/components/DescriptionAsso.dart';
import 'package:assosnation_app/components/an_bigTitle.dart';
import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/firestore/posts/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationDetails extends StatelessWidget {
  final Association assos;
  AssociationDetails(this.assos);

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Association Page"),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                color: Colors.teal,
                child: AnBigTitle(assos.name),
                height: 70,
              ),
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
                          } else {
                            FireStoreService()
                                .subscribeToAssociation(assos.uid, _user.uid);
                          }
                        }
                      },
                      icon: Icon(assos.didUserSubscribed(_user!.uid)
                          ? Icons.add_circle
                          : Icons.remove_circle),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.message_outlined),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/messagingPage");
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.date_range),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/associationCalendarPage",
                        arguments: assos);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 50,
                          title: Icon(
                            Icons.info_sharp,
                            color: Colors.teal,
                            size: 55,
                          ),
                          actions: [
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.location,
                                  color: Colors.teal,
                                ),
                                Text(
                                  assos.address,
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city_rounded,
                                  color: Colors.teal,
                                ),
                                Text(
                                  assos.city,
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.teal,
                                ),
                                Text(
                                  assos.phone,
                                  style: TextStyle(color: Colors.teal),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(CupertinoIcons.person_alt_circle,
                                    color: Colors.teal),
                                Text(
                                  assos.president,
                                  style: TextStyle(color: Colors.teal),
                                )
                              ],
                            ),
                          ],
                        );
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsFeedCard(postList[index]);
                      },
                      itemCount: postList.length,
                    );
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
