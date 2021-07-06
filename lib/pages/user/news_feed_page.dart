import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/empty_newsfeed.dart';
import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Container(
      child: Column(
        children: [
          AnTitle("${AppLocalizations.of(context)!.user_tab_newsfeed}"),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: FireStoreService()
                      .getAllPostsByAssociationList(_user!.subscriptions),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        List<dynamic> postList = snapshot.data!;
                        if (snapshot.data!.length == 0)
                          return EmptyNewsFeed();
                        else {
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                setState(() {});
                              },
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return NewsFeedCard(postList[index]['post'],
                                      postList[index]['assosName'], _user.uid);
                                },
                                itemCount: postList.length,
                                shrinkWrap: true,
                                cacheExtent: 4,
                              ),
                            ),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting)
                        return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container(
                        child:
                            Text(AppLocalizations.of(context)!.error_no_infos),
                      );
                    }
                    return EmptyNewsFeed();
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
