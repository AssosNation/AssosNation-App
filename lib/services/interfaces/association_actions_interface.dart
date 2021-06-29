import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AssociationActionsInterface {
  Future createAssociationActionForAssociation(AssociationAction action);

  Stream<QuerySnapshot> retrieveAllAssociationActionForAssociationStream(
      Association assos);

  Future removeAssociationAction(AssociationAction action);
  Future updateAssociationAction(
      AssociationAction oldAction, AssociationAction newAction);
}
