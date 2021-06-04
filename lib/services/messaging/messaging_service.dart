import 'package:assosnation_app/services/interfaces/messaging_interface.dart';
import 'package:assosnation_app/services/models/conversation.dart';
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
      print("Error when getting Conversations by User");
      print(e.message);
      return Future.error("Error when getting Conversations by User");
    }
  }

  @override
  Future<List<dynamic>> getAllMessagesByConversation(String convId) async {
    try {
      DocumentSnapshot conversationSnapshot =
          await _service.collection("conversations").doc(convId).get();

      List<dynamic> _messages = conversationSnapshot.get("messages");
      return _messages;
    } on FirebaseException catch (e) {
      print("Error when getting messages from conversation $convId");
      return Future.error(
          "Error when getting messages from conversation $convId");
    }
  }
}
