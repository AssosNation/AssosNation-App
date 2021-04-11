import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DocumentReference convId;
  final String content;
  final DocumentReference sender;
  final Timestamp timestamp;

  Message({ required this.content, required this.convId, required this.sender,
    required this.timestamp});
}