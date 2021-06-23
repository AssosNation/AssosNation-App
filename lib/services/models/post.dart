import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final DocumentReference assosId;
  final String content;
  final String photo;
  final Timestamp timestamp;
  List usersWhoLiked;

  Post(this.id, this.title, this.assosId, this.content, this.photo,
      this.timestamp, this.usersWhoLiked);

  didUserLikeThePost(String uid) {
    return usersWhoLiked.contains(uid);
  }
}
