import 'package:assosnation_app/services/models/conversation.dart';

abstract class MessagingInterface {
  Future<List<Conversation>> getAllConversationsByUser(String uid);
  Future<List<dynamic>> getAllMessagesByConversation(String convId);
}
