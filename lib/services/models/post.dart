import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  final String name;
  final String assosId;
  final int likesNumber;
  final String content;
  final String photo;
  final Timestamp timestamp;
  final List<AnUser> usersWhoLiked;

  Post(this.name, this.assosId, this.likesNumber, this.content, this.photo,
      this.timestamp, this.usersWhoLiked);

}