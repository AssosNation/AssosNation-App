import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                  future: FireStoreService()
                      .getAllPostsByAssociationList(_user?.subscriptions),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return CircularProgressIndicator();
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          List<dynamic> postList = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return NewsFeedCard(postList[index]['post'],
                                    postList[index]['assosName'], _user!.uid);
                              },
                              itemCount: postList.length,
                              shrinkWrap: true,
                            ),
                          );
                      }
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container(
                        child: Text("Something wrong happened"),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
