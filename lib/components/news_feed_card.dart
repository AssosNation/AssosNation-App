import 'package:assosnation_app/components/news_feed_like_component.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'forms/form_main_title.dart';

class NewsFeedCard extends StatefulWidget {
  final Post _post;
  final String _assosName;
  final _userId;

  NewsFeedCard(this._post, this._assosName, this._userId);

  @override
  _NewsFeedCardState createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.elliptical(15, 10),
                right: Radius.elliptical(10, 15))),
        elevation: 3.0,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 5, 5),
                        child: FutureBuilder(
                          future: StorageService()
                              .getBannerByAssociation(widget._post.assosId.id),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return CircleAvatar(
                                  child: FittedBox(
                                    child: Image.network(snapshot.data!),
                                  ),
                                );
                              } else
                                return CircularProgressIndicator();
                            }
                            return Container();
                          },
                        ),
                      ),
                      Text(widget._assosName)
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                FormMainTitle(
                  this.widget._post.title,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                        child: Text(
                          this.widget._post.content,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future:
                            StorageService().getImageByPost(widget._post.id),
                        builder: (ctx, AsyncSnapshot<String> snapshots) {
                          if (snapshots.hasData) {
                            switch (snapshots.connectionState) {
                              case ConnectionState.done:
                                return Image.network(
                                  snapshots.data!,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                );
                              case ConnectionState.waiting:
                                return CircularProgressIndicator();
                              case ConnectionState.active:
                                return CircularProgressIndicator();
                              case ConnectionState.none:
                                return CircularProgressIndicator();
                            }
                          }
                          return Container();
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd MM yyyy').add_Hm().format(DateTime.parse(
                            this.widget._post.timestamp.toDate().toString())),
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                NewsFeedLikeComponent(
                    this.widget._post.usersWhoLiked.length,
                    this.widget._post.didUserLikeThePost(this.widget._userId),
                    this.widget._post,
                    this.widget._userId)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
