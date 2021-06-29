import 'package:assosnation_app/services/interfaces/asso_details_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationService implements AssoDetailsInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future updateName(Association assos, String content) async {
    DocumentReference assoRef =
        _service.collection("associations").doc(assos.uid);
    try {
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
      return Future.error("Cannot update phone with id ${assos.uid}");
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
      return Future.error("Cannot update phone with id ${assos.uid}");
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
