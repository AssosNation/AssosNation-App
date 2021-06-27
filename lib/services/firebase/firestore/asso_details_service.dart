import 'package:assosnation_app/services/interfaces/asso_details_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssoDetailsService implements AssoDetailsInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future updateName(Association assos, String content) async {
    DocumentReference postRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await postRef.update({
        "name": content,
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update name with id ${assos.uid}");
    }
  }

  @override
  Future updatePhone(Association assos, String content) async {
    DocumentReference postRef =
        _service.collection("associations").doc(assos.uid);
    try {
      await postRef.update({
        "phone": content,
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update phone with id ${assos.uid}");
    }
  }
}
