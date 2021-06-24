import 'package:assosnation_app/components/dialog/delete_confirmation_dialog.dart';
import 'package:assosnation_app/components/dialog/edit_post_dialog.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forms/form_main_title.dart';

class AssociationPostCard extends StatefulWidget {
  final Post _post;
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.elliptical(15, 10),
                right: Radius.elliptical(10, 15))),
        child: Column(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => DeletePostConfirmationDialog(
                            "Are you sure to delete this post ?",
                            widget._post.id),
                      ),
                      label: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => EditPostDialog(widget._post),
                      ),
                      label: Text("Edit"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
