import 'package:assosnation_app/services/interfaces/messaging_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/message.dart';
import 'package:assosnation_app/services/models/user.dart';
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
            e.id, e.get("messages"), e.get("participants"), e.get("names"));
      }).toList();

      return _conversationList;
    } on FirebaseException catch (e) {
      return Future.error("Error when getting Conversations by User");
    }
  }

  @override
  Future<List<Conversation>> getAllConversationsByAssociation(String id) async {
    CollectionReference _conversations = _service.collection("conversations");

    DocumentReference assosRef = _service.doc("associations/$id");
    try {
      QuerySnapshot snapshot = await _conversations
          .where("participants", arrayContains: assosRef)
          .get();

      List<Conversation> _conversationList = snapshot.docs.map((e) {
        return Conversation(
            e.id, e.get("messages"), e.get("participants"), e.get("names"));
      }).toList();

      return _conversationList;
    } on FirebaseException catch (e) {
      return Future.error("Error when getting Conversations by User");
    }
  }

  @override
  Future<List> getAllMessagesByConversation(String convId) async {
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

  @override
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

  @override
  Stream<QuerySnapshot> watchAllConversationsByAssos(Association assos) {
    DocumentReference assosRef =
        _service.collection("associations").doc(assos.uid);
    CollectionReference conversationRef = _service.collection("conversations");
    return conversationRef
        .where("participants", arrayContains: assosRef)
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot> watchConversationById(String convId) {
    CollectionReference conversationRef = _service.collection("conversations");
    return conversationRef.doc(convId).snapshots();
  }

  @override
  Future sendMessageToConversation(
      String convId, DocumentReference senderRef, String msg) async {
    try {
      DocumentReference convRef =
          _service.collection("conversations").doc(convId);

      await convRef.update({
        "messages": FieldValue.arrayUnion([
          {"content": msg, "sender": senderRef, "timestamp": Timestamp.now()}
        ])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Error when retrieving participant's name");
    }
  }

  @override
  Stream<QuerySnapshot> watchAllConversationsByUser(AnUser user) {
    DocumentReference userRef = _service.collection("users").doc(user.uid);
    CollectionReference conversationRef = _service.collection("conversations");
    return conversationRef
        .where("participants", arrayContains: userRef)
        .snapshots();
  }

  @override
  Future initConversationIfNotFound(
      String userId, String assosId, String userName, String assosName) async {
    try {
      DocumentReference userRef = _service.collection("users").doc(userId);
      DocumentReference assosRef =
          _service.collection("associations").doc(assosId);
      CollectionReference convRef = _service.collection("conversations");

      final convExist = await convRef
          .where("participants", isEqualTo: [userRef, assosRef]).get();
      if (convExist.docs.length == 0) {
        final result = await convRef.add({
          "messages": [],
          "participants": [userRef, assosRef],
          "names": [userName, assosName]
        });
        return Conversation(
            result.id, [], [userRef, assosRef], [userName, assosName]);
      }
      return Conversation(
          convExist.docs.single.id,
          convExist.docs.single.get("messages"),
          convExist.docs.single.get("participants"),
          convExist.docs.single.get("names"));
    } on FirebaseException catch (e) {
      Future.error("Cannot init or find any conversations, something happened");
    }
  }
}
