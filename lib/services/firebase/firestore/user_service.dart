import 'package:assosnation_app/services/interfaces/user_service_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'gamification_service.dart';

class UserService extends UserServiceInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future addUserToDB(user) async {
    CollectionReference users = _service.collection("users");
    try {
      user as AnUser;

      await users.doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'mail': user.mail,
        'subscriptions': user.subscriptions,
        'gamificationRef': user.gamificationRef,
        'profileImg': user.profileImg
      });

      return true;
    } on FirebaseException catch (e) {
      Future.error("Error while adding user to database");
    }
  }

  @override
  Future<AnUser> getUserInfosFromDB(String uid) async {
    CollectionReference _users = _service.collection("users");
    try {
      DocumentSnapshot snapshot = await _users.doc(uid).get();
      final _user = AnUser.withData(
        uid,
        snapshot.get('mail'),
        snapshot.get('firstName'),
        snapshot.get('lastName'),
        snapshot.get("subscriptions"),
        snapshot.get("gamificationRef"),
        snapshot.get("profileImg"),
      );
      return _user;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all user data");
    }
  }

  @override
  Future getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  Future updateUserProfileImg(String userId, String imgUrl) async {
    try {
      DocumentReference userRef = _service.collection("users").doc(userId);
      await userRef.update({"profileImg": imgUrl});

      return true;
    } on FirebaseException catch (e) {
      Future.error("Couldn't change user's profile image");
    }
  }

  Future addUserToAction(AssociationAction action, _userId) async {
    Association association = action.association;
    association.actions![action.id]['usersRegistered'].add(_userId);
    _service
        .collection('associations')
        .doc(association.uid)
        .update({"actions": association.actions});
    final userInfo = await _service.collection("users").doc(_userId).get();
    await GamificationService()
        .increaseEventRegistrationByOne(userInfo.get("gamificationRef").id);
  }

  Future removeUserToAction(AssociationAction action, _userId) async {
    Association association = action.association;
    association.actions![action.id]['usersRegistered']
        .removeWhere((userId) => userId == _userId);
    _service
        .collection('associations')
        .doc(association.uid)
        .update({"actions": association.actions});
    final userInfo = await _service.collection("users").doc(_userId).get();
    await GamificationService()
        .decreaseEventRegistrationByOne(userInfo.get("gamificationRef").id);
  }

  Future addUsersToLikedList(String postId, AnUser user) async {
    await _service.collection('posts').doc(postId).update({
      'usersWhoLiked': FieldValue.arrayUnion([user.uid])
    });
    await GamificationService()
        .increaseLikeNumberByOne(user.gamificationRef.id);
  }

  Future removeUserToLikedList(String postId, AnUser user) async {
    _service.collection('posts').doc(postId).update({
      'usersWhoLiked': FieldValue.arrayRemove([user.uid])
    });
    await GamificationService()
        .decreaseLikeNumberByOne(user.gamificationRef.id);
  }

  @override
  Future<bool> checkIfUserIsAssos(String uid) async {
    DocumentReference assosRef = _service.collection("associations").doc(uid);
    try {
      final assos = await assosRef.get();
      return assos.exists;
    } on FirebaseException catch (e) {
      return Future.error("Error while retrieving an association");
    }
  }

  @override
  Future removeUserFromDB(String uid) {
    // TODO: implement removeUserFromDB
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot> watchUserInfos(AnUser user) {
    DocumentReference userRef = _service.collection("users").doc(user.uid);
    return userRef.snapshots();
  }
}
