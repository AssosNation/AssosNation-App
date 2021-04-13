import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService extends DatabaseInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future getAllConversations() {
    // TODO: implement getAllConversations
    throw UnimplementedError();
  }

  @override
  Future getAllMessagesByConversation() {
    // TODO: implement getAllMessagesByConversation
    throw UnimplementedError();
  }

  @override
  Future getAllPostsByAssociation() {
    // TODO: implement getAllPostsByAssociation
    throw UnimplementedError();
  }

  @override
  Future getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future getAssociationsList() {
    // TODO: implement getAssociationsList
    throw UnimplementedError();
  }

  @override
  Future addUserToDB(user) async {
    CollectionReference users = _service.collection("users");
    try {
      user as User;

      await users.doc(user.uid).set({
        'firstName': "",
        'lastName': "",
        'mail': user.email,
        'subscriptions': ""
      });
    } on FirebaseException catch (e) {
      print("Error while adding user to database");
      print(e.message);
    }
  }

  @override
  Future getUserInfosFromDB(uid) async {
    // DocumentReference _userRef = users.doc(uid);
  }

  @override
  Future removeUserFromDB(uid) {
    // TODO: implement removeUserFromDB
    throw UnimplementedError();
  }
}
