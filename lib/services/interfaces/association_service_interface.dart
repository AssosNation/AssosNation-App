import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AssociationServiceInterface {
  Future subscribeToAssociation(String associationId, String userId);

  Future unsubscribeToAssociation(String associationId, String userId);

  Future updateName(Association assos, String content);

  Future updatePhone(Association assos, String content);

  Future updateAddress(Association assos, String content);

  Future updateCity(Association assos, String content);

  Future updateDescription(Association assos, String content);

  Stream<DocumentSnapshot> watchAssociationInfo(Association assos);
}
