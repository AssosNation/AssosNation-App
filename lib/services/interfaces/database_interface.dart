import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();

  Future getAllUsers();

  Future addUserToDB(user);

  Future<AnUser?> getUserInfosFromDB(String uid);

  Future removeUserFromDB(String uid);

  Future addAssociationToDb(Association association);

  Future<List<Association>> getSubscribedAssociationsByUser(AnUser user);

  Future<Association> getAssociationInfosFromDB(String assosId);

  Future<bool> checkIfUserIsAssos(String uid);

  Future<List<AssociationAction>> getAllActionsByAssociation(
      Association assos, AnUser user);

  Future addUsersToLikedList(String postId, AnUser user);

  Future removeUserToLikedList(String postId, AnUser user);
}
