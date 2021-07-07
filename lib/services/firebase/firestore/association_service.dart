import 'package:assosnation_app/services/interfaces/association_service_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationService extends AssociationServiceInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future subscribeToAssociation(String associationId, String userId) async {
    try {
      DocumentReference assosRef =
          _service.collection("associations").doc(associationId);
      DocumentReference userRef = _service.collection("users").doc(userId);
      await _service.collection('users').doc(userId).update({
        'subscriptions': FieldValue.arrayUnion([assosRef])
      });

      await _service.collection('associations').doc(associationId).update({
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
      await _service.collection('users').doc(userId).update({
        'subscriptions': FieldValue.arrayRemove([assosRef])
      });

      await _service.collection('associations').doc(associationId).update({
        'subscribers': FieldValue.arrayRemove([userRef])
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error(
          "Error while unsubscribing to assos => $associationId");
    }
  }

  @override
  Future updateName(Association assos, String content) async {
    CollectionReference _conversations = _service.collection("conversations");
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
      QuerySnapshot snapshot = await _conversations
          .where("participants", arrayContains: assoRef)
          .get();

      snapshot.docs.forEach((e) async {
        e.reference.update({
          'names': [e.get("names")[0], content]
        });
      });

      await assoRef.update({"name": content});

      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update name with id ${assos.uid}");
    }
  }

  @override
  Future updatePhone(Association assos, String content) async {
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await assoRef.update({"phone": content});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update phone with id ${assos.uid}");
    }
  }

  @override
  Future updateAddress(Association assos, String content) async {
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await assoRef.update({"address": content});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update address with id ${assos.uid}");
    }
  }

  @override
  Future updateCity(Association assos, String content) async {
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await assoRef.update({"city": content});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update city with id ${assos.uid}");
    }
  }

  @override
  Future updateDescription(Association assos, String content) async {
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await assoRef.update({"description": content});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update phone with id ${assos.uid}");
    }
  }

  Stream<DocumentSnapshot> watchAssociationInfo(Association assos) {
    return _service.collection("associations").doc(assos.uid).snapshots();
  }
}
