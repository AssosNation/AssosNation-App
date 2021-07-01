import 'package:assosnation_app/components/dialog/delete_confirmation_dialog.dart';
import 'package:assosnation_app/components/posts/edit_post_dialog.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationPostCard extends StatefulWidget {
  final Post _post;

  AssociationPostCard(this._post);

  @override
  _AssociationPostCardState createState() => _AssociationPostCardState();
}

class _AssociationPostCardState extends State<AssociationPostCard> {
  @override
  Widget build(BuildContext context) {
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
            PostMainTitle(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => EditPostDialog(widget._post),
                      ),
                      label: Text(AppLocalizations.of(context)!.edit_button),
                    ),
                    OutlinedButton.icon(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => DeleteObjectConfirmationDialog(
                            AppLocalizations.of(context)!.delete_alert_msg,
                            widget._post.id,
                            null),
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.delete_button,
                        style: TextStyle(color: Colors.red),
                      ),
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
