import 'package:assosnation_app/components/association_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forms/form_main_title.dart';

class NewsFeedCard extends StatefulWidget {
  final _post;
  NewsFeedCard(this._post);

  @override
  _NewsFeedCardState createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard> {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => FireStoreService()
                  .getAssociationInfosFromDBWithReference(
                      this.widget._post.assosId)
                  .then((association) => Navigator.of(context).pushNamed(
                      "/associationDetails",
                      arguments: association)),
              child: Column(
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
                        //Text(this.widget._post.title)
                      ],
                    ),
                  )
                ],
              ),
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
                    Text(this.widget._post.usersWhoLiked.length.toString()),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          if (_user != null) {
                            if (widget._post.didUserLikeThePost(_user.uid)) {
                              FireStoreService().removeUserToLikedList(
                                  widget._post.id, _user.uid);
                            } else {
                              FireStoreService().addUsersToLikedList(
                                  widget._post.id, _user.uid);
                            }
                          }
                        },
                        icon: Icon(widget._post.didUserLikeThePost(_user!.uid)
                            ? Icons.thumb_up_alt_rounded
                            : Icons.thumb_up_alt_outlined),
                        label: Text(widget._post.didUserLikeThePost(_user.uid)
                            ? "Liked !"
                            : "Like")),
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
