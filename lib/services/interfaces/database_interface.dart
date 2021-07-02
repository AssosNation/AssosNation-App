import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseInterface {
  Future<List<Association>> getAllAssociations();

  Future addAssociationToDb(Association association);

  Future<List<Association>> getSubscribedAssociationsByUser(AnUser user);

  Future<Association> getAssociationInfosFromDB(String assosId);

  Future<List<AssociationAction>> getAllActionsByAssociation(
      Association assos, AnUser user);

  Future<List<dynamic>> getAllPostsByAssociationList(List? associationList);

  Future<Map<DocumentReference, String>> getAssociationListName(
      associationList);

  Future<Association> getAssociationInfosFromDBWithReference(
      DocumentReference association);

  Future<List<AssociationAction>> getActionByAssociationReference(
      DocumentReference reference, _userId);

  Future<List<AssociationAction>> getAllActions(_userId);

  List<AssociationAction> getActionsByAssociation(
      Association association, _userId);

  Future<List<AssociationAction>> getUserAssociationsByDate(_userId);
}
