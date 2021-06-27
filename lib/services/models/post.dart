import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id = "";
  String title;
  String assosId;
  String content;
  String photo;
  Timestamp timestamp = Timestamp.now();
  List usersWhoLiked = [];

  Post(this.id, this.title, this.assosId, this.content, this.photo,
      this.timestamp, this.usersWhoLiked);

  Post.creation(this.title, this.assosId, this.content, this.photo);

  didUserLikeThePost(String uid) {
    return usersWhoLiked.contains(uid);
  }
}
