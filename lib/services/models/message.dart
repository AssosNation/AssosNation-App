import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DocumentReference convId;
  final String content;
  final DocumentReference sender;
  final Timestamp timestamp;

  Message(this.content, this.convId, this.sender, this.timestamp);
}