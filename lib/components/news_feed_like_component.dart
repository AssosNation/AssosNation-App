import 'package:assosnation_app/services/firebase/firestore/user_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsFeedLikeComponent extends StatefulWidget {
  var _likesNumber;
  var _userLiked;
  final _userId;
  final Post _post;
  NewsFeedLikeComponent(
      this._likesNumber, this._userLiked, this._post, this._userId);

  @override
  _NewsFeedLikeComponentState createState() => _NewsFeedLikeComponentState();
}

class _NewsFeedLikeComponentState extends State<NewsFeedLikeComponent> {
  updateState(likeAction) {
    setState(() {
      widget._likesNumber = widget._likesNumber + (likeAction ? 1 : -1);
      widget._userLiked = likeAction;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.thumb_up,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(widget._likesNumber.toString()),
            ],
          ),
        ),
        TextButton.icon(
            onPressed: () {
              Share.share(
                  '${widget._post.title}\n${widget._post.content}\nPartagé depuis l\'application AssosNation.');
            },
            icon: Icon(Icons.share),
            label: Text('Partager')),
        TextButton.icon(
            onPressed: () {
              if (widget._userLiked) {
                UserService().removeUserToLikedList(widget._post.id, _user!);
                updateState(false);
              } else {
                UserService().addUsersToLikedList(widget._post.id, _user!);
                updateState(true);
              }
            },
            icon: Icon(widget._userLiked
                ? Icons.thumb_up_alt_rounded
                : Icons.thumb_up_alt_outlined),
            label: Text(this.widget._userLiked
                ? AppLocalizations.of(context)!.post_liked
                : AppLocalizations.of(context)!.like_post)),
      ],
    );
  }
}
