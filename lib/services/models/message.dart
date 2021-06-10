import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final DocumentReference sender;
  final Timestamp timestamp;

  Message(this.content, this.sender, this.timestamp);
}
