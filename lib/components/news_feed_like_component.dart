import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsFeedLikeComponent extends StatefulWidget {
  var _likesNumber;
  var _userLiked;
  final _userId;
  final _postId;
  NewsFeedLikeComponent(
      this._likesNumber, this._userLiked, this._postId, this._userId);

  @override
  _NewsFeedLikeComponentState createState() => _NewsFeedLikeComponentState();
}

class _NewsFeedLikeComponentState extends State<NewsFeedLikeComponent> {
  updateState(likeAction) {
    setState(() {
      this.widget._likesNumber =
          this.widget._likesNumber + (likeAction ? 1 : -1);
      this.widget._userLiked = likeAction;
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
              Text(this.widget._likesNumber.toString()),
            ],
          ),
        ),
        TextButton.icon(
            onPressed: () {
              if (this.widget._userLiked) {
                FireStoreService()
                    .removeUserToLikedList(widget._postId, _user!);
                updateState(false);
              } else {
                FireStoreService().addUsersToLikedList(widget._postId, _user!);
                updateState(true);
              }
            },
            icon: Icon(this.widget._userLiked
                ? Icons.thumb_up_alt_rounded
                : Icons.thumb_up_alt_outlined),
            label: Text(this.widget._userLiked ? "Liked !" : "Like")),
      ],
    );
  }
}
