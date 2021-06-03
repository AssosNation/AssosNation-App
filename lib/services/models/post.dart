import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

  final String title;
  final String assosId;
  final int likesNumber;
  final String content;
  final String photo;

  Post(this.title, this.assosId, this.likesNumber, this.content, this.photo);
}