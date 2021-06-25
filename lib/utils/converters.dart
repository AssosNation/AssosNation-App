import 'package:assosnation_app/services/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Converters {
  static List<Post> convertDocSnapshotsToListPost(List<DocumentSnapshot> docs) {
    return docs
        .map((e) => Post(
            e.id,
            e.get("title"),
            e.get("assosId").id,
            e.get("content"),
            e.get("photo"),
            e.get("timestamp"),
            e.get("usersWhoLiked")))
        .toList();
  }
}
