import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
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

  static List<Conversation> convertDocSnapshotsToConvList(
      List<DocumentSnapshot> docs) {
    return docs
        .map((e) => Conversation(
            e.id, e.get("messages"), e.get("participants"), e.get("names")))
        .toList();
  }

  static Conversation convertDocSnapshotsToConv(DocumentSnapshot doc) {
    return Conversation(
        doc.id, doc.get("messages"), doc.get("participants"), doc.get("names"));
  }

  static Association convertDocSnapshotsToAssos(DocumentSnapshot doc) {
    return Association(
        doc.id,
        doc.get("name"),
        doc.get("description"),
        doc.get("mail"),
        doc.get("address"),
        doc.get("city"),
        doc.get("postalCode"),
        doc.get("phone"),
        doc.get("banner"),
        doc.get("president"),
        doc.get("approved"),
        doc.get("type"),
        doc.get("posts"),
        doc.get("actions"),
        doc.get("subscribers"));
  }
}
