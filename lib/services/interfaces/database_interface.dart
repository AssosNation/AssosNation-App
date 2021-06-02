import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/message.dart';
import 'package:assosnation_app/services/models/user.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future getAllConversations();
  Future addUserToDB(user);
  Future<AnUser?> getUserInfosFromDB(String uid);
  Future removeUserFromDB(String uid);
  Future addAssociationToDb(Association association);
  Future<List<Association>> getSubscribedAssociationByUser(String uid);
  Future getAllConversationsByUser(AnUser user);
  Future<List<Message>> getAllMessagesByConversation(
      Conversation _conversation);
}
