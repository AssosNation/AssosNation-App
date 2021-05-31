import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:assosnation_app/services/models/user.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future getAllConversations();
  Future addUserToDB(user);
  Future getUserInfosFromDB(uid);
  Future removeUserFromDB(uid);
  Future addAssociationToDb(association);
  Future getAllConversationsByUser(AnUser user);
  Future getAllMessagesByConversation(Conversation conversation);
}
