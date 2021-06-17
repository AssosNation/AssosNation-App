import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forms/form_main_title.dart';

class NewsFeedCard extends StatefulWidget {
  Post _post;

  NewsFeedCard(this._post);

  @override
  _NewsFeedCardState createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 10.0,
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
                        child: CircleAvatar(),
                      ),
                      Text(this.widget._post.title)
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
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Icon(
                        Icons.thumb_up,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(this.widget._post.likesNumber.toString()),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          if (widget._post.userLiked) {
                            FireStoreService().removeUserToLikedList(
                                widget._post.id,
                                'test'); //TODO : get the real user id
                          } else {
                            FireStoreService().addUsersToLikedList(
                                widget._post.id,
                                'test'); //TODO : get the real user id
                          }
                        },
                        icon: Icon(widget._post.userLiked
                            ? Icons.thumb_up_alt_rounded
                            : Icons.thumb_up_alt_outlined),
                        label: Text("Like")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
