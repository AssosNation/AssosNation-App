import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future addUserToDB(user);
  Future<AnUser?> getUserInfosFromDB(String uid);
  Future removeUserFromDB(String uid);
  Future addAssociationToDb(Association association);
  Future<List<Association>> getSubscribedAssociationsByUser(String uid);
  Future<Association> getAssociationInfosFromDB(String assosId);
}
