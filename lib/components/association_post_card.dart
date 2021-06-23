import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dialog/delete_confirmation_dialog.dart';
import 'dialog/edit_post_dialog.dart';
import 'forms/form_main_title.dart';

class AssociationPostCard extends StatefulWidget {
  final _post;
  AssociationPostCard(this._post);

  @override
  _AssociationPostCardState createState() => _AssociationPostCardState();
}

class _AssociationPostCardState extends State<AssociationPostCard> {
  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) => EditPostDialog(),
                              )),
                      IconButton(
                          icon: Icon(Icons.delete_forever_outlined),
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) => DeleteConfirmationDialog(
                                    "Are you sure to delete this post ?"),
                              )),
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
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
