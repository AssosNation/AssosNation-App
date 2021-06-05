import 'package:assosnation_app/services/interfaces/messaging_interface.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService extends MessagingInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future<List<Conversation>> getAllConversationsByUser(String uid) async {
    CollectionReference _conversations = _service.collection("conversations");
    DocumentReference _userRef = _service.doc("users/$uid");
    try {
      QuerySnapshot snapshot = await _conversations
          .where("participants", arrayContains: _userRef)
          .get();

      List<Conversation> _conversationList = snapshot.docs.map((e) {
        return Conversation(
            e.id, e.get("title"), e.get("messages"), e.get("participants"));
      }).toList();

      return _conversationList;
    } on FirebaseException catch (e) {
      return Future.error("Error when getting Conversations by User");
    }
  }

  @override
  Future<List<dynamic>> getAllMessagesByConversation(String convId) async {
    try {
      DocumentSnapshot snapshot =
          await _service.collection("conversations").doc(convId).get();

      List _messages = snapshot.get("messages");
      List<Message> msgList = _messages
          .map((e) => Message(e["content"], e["sender"], e["timestamp"]))
          .toList();
      return msgList;
    } on FirebaseException catch (e) {
      return Future.error(
          "Error when getting messages from conversation $convId");
    }
  }

  Future<String> getParticipantName(DocumentReference ref) async {
    try {
      DocumentSnapshot snapshot = await ref.get();
      if (ref.path.contains("users"))
        return "${snapshot.get("firstName")} ${snapshot.get("lastName")}";
      else
        return snapshot.get("name");
    } on FirebaseException catch (e) {
      return Future.error("Error when retrieving participant's name");
    }
  }
}
