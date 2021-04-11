import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final List<DocumentReference> messages;
  final List<DocumentReference> participants;
  final String title;

  Conversation(this.messages, this.participants, this.title);
}