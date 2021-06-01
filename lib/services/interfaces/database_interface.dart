import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future getAllConversations();
  Future getAllMessagesByConversation();
  Future addUserToDB(user);
  Future<AnUser?> getUserInfosFromDB(uid);
  Future removeUserFromDB(uid);
  Future addAssociationToDb(association);
}
