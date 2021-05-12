import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:assosnation_app/services/models/user.dart';
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
  Future addUserToDB(user) async {
    CollectionReference users = _service.collection("users");
    try {
      user as AnUser;

      await users.doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'mail': user.mail,
        'subscriptions': []
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

  @override
  Future getAllAssociations() async {
    CollectionReference associations = _service.collection("associations");
    try {
      QuerySnapshot snapshot = await associations.get();
      print(snapshot.docs.length);
      /*snapshot.docs.forEach((element) {
        print(element.data());
      });*/
      /*final toto = snapshot.docs.map((e) => Association(
          e["name"],
          e["description"],
          e["mail"],
          e["address"],
          e["city"],
          e["postalCode"],
          e["phone"],
          e["banner"],
          e["president"],
          e["type"],
          e["posts"],
          e["actions"]));*/
    } on FirebaseException catch (e) {
      print("Error while adding user to database");
      print(e.message);
    }
  }
}
