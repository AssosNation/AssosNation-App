import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessagingInterface {
  Future<List<Conversation>> getAllConversationsByUser(String uid);

  Future<List<dynamic>> getAllMessagesByConversation(String convId);

  Future<List<Conversation>> getAllConversationsByAssociation(String id);

  Future<String> getParticipantName(DocumentReference ref);

  Stream<DocumentSnapshot> watchConversationById(String convId);

  Stream<QuerySnapshot> watchAllConversationsByAssos(Association assos);

  Future sendMessageToConversation(
      String convId, DocumentReference senderRef, String msg);

  Stream<QuerySnapshot> watchAllConversationsByUser(AnUser user);

  Future initConversationIfNotFound(
      String userId, String assosId, String userName, String assosName);
}
