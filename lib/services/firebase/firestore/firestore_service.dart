import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:assosnation_app/services/models/post.dart';
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
  Future<List<Post>> getAllPostsByAssociation() async {
    CollectionReference posts = _service.collection("posts");
    try {
      QuerySnapshot snapshot = await posts.get();
      List<Post> postList = snapshot.docs
          .map((post) => Post(
          post.get('title'),
          post.get('assosId').toString(),
          post.get('likesNumber'),
          post.get('content'),
          post.get('photo')))
          .toList();
        return postList;
      } on FirebaseException catch (e) {
      return Future.error("Error while retrieving all posts");
    }
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
}
