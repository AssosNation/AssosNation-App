import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String _uid;
  final String title;
  final List<DocumentReference> messages;
  final List<DocumentReference> participants;

  Conversation(this._uid, this.title, this.messages, this.participants);
}
