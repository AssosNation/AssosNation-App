import 'package:assosnation_app/services/interfaces/association_service_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationService extends AssociationServiceInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future subscribeToAssociation(String associationId, String userId) async {
    try {
      DocumentReference assosRef =
          _service.collection("associations").doc(associationId);
      DocumentReference userRef = _service.collection("users").doc(userId);
      _service.collection('users').doc(userId).update({
        'subscriptions': FieldValue.arrayUnion([assosRef])
      });

      _service.collection('associations').doc(associationId).update({
        'subscribers': FieldValue.arrayUnion([userRef])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Error while subscribing to assos => $associationId");
    }
  }

  @override
  Future unsubscribeToAssociation(String associationId, String userId) async {
    try {
      DocumentReference assosRef =
          _service.collection("associations").doc(associationId);
      DocumentReference userRef = _service.collection("users").doc(userId);
      _service.collection('users').doc(userId).update({
        'subscriptions': FieldValue.arrayRemove([assosRef])
      });

      _service.collection('associations').doc(associationId).update({
        'subscribers': FieldValue.arrayRemove([userRef])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error(
          "Error while unsubscribing to assos => $associationId");
    }
  }
}
