import 'package:assosnation_app/components/dialog/delete_confirmation_dialog.dart';
import 'package:assosnation_app/components/posts/edit_post_dialog.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationPostCard extends StatefulWidget {
  final Post _post;

  AssociationPostCard(this._post);

  @override
  _AssociationPostCardState createState() => _AssociationPostCardState();
}

class _AssociationPostCardState extends State<AssociationPostCard> {
  Widget _displayImageIfExists() {
    if (widget._post.photo != "")
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: CachedNetworkImage(
              imageUrl: widget._post.photo,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      );
    return Container();
  }

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
              widget._post.title,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                    child: Text(
                      widget._post.content,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
            _displayImageIfExists(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.people),
                    Text(widget._post.usersWhoLiked.length.toString()),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            icon: Icon(Icons.edit),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EditPostDialog(widget._post),
                            ),
                            label:
                                Text(AppLocalizations.of(context)!.edit_button),
                          ),
                          OutlinedButton.icon(
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  DeleteObjectConfirmationDialog(
                                      AppLocalizations.of(context)!
                                          .delete_alert_msg,
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
