import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final id;
  final DocumentReference convId;
  final String content;
  final DocumentReference sender;
  final Timestamp timestamp;

  Message(this.id, this.content, this.convId, this.sender, this.timestamp);
}
