import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:assosnation_app/services/models/associationAction.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService extends DatabaseInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future<List<Post>> getAllPostsByAssociation() async {
    CollectionReference posts = _service.collection("posts");
    try {
      QuerySnapshot snapshot = await posts.get();
      List<Post> postList = snapshot.docs
          .map((post) => Post(
              post.id,
              post.get('title'),
              post.get('assosId').toString(),
              post.get('likesNumber'),
              post.get('content'),
              post.get('photo'),
              post.get('timestamp').toDate()))
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
  Future<AnUser> getUserInfosFromDB(uid) async {
    CollectionReference _users = _service.collection("users");
    try {
      DocumentSnapshot snapshot = await _users.doc(uid).get();
      final _user = AnUser.withData(
          uid,
          snapshot.get('mail'),
          snapshot.get('firstName'),
          snapshot.get('lastName'),
          snapshot.get("subscriptions"));
      return _user;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all user data");
    }
  }

  Future<Association> getAssociationInfosFromDB(String assosId) async {
    CollectionReference associations = _service.collection("associations");
    try {
      DocumentSnapshot snapshot = await associations.doc(assosId).get();

      final assos = Association(
          snapshot.id,
          snapshot.get("name"),
          snapshot.get("description"),
          snapshot.get("mail"),
          snapshot.get("address"),
          snapshot.get("city"),
          snapshot.get("postalCode"),
          snapshot.get("phone"),
          snapshot.get("banner"),
          snapshot.get("president"),
          snapshot.get("approved"),
          snapshot.get("type"),
          snapshot.get("posts"),
          snapshot.get("actions"),
          snapshot.get("subscribers"));
      return assos;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving association data");
    }
  }

  @override
  Future removeUserFromDB(uid) {
    // TODO: implement removeUserFromDB
    throw UnimplementedError();
  }

  @override
  Future<List<Association>> getAllAssociations() async {
    CollectionReference associations = _service.collection("associations");
    try {
      QuerySnapshot snapshot = await associations.get();
      List<Association> assosList = snapshot.docs
          .map((e) => Association(
              e.id,
              e.get("name"),
              e.get("description"),
              e.get("mail"),
              e.get("address"),
              e.get("city"),
              e.get("postalCode"),
              e.get("phone"),
              e.get("banner"),
              e.get("president"),
              e.get("approved"),
              e.get("type"),
              e.get("posts"),
              e.get("actions"),
              e.get("subscribers")))
          .toList();
      return assosList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all associations");
    }
  }

  @override
  Future addAssociationToDb(Association association) async {
    CollectionReference assos = _service.collection("associations");
    try {
      await assos.doc(association.uid).set({
        'name': association.name,
        'description': association.description,
        'president': association.president,
        'address': association.address,
        'city': association.city,
        'postalCode': association.postalCode,
        'phone': association.phone,
        'mail': association.mail,
        'banner': association.banner,
        'type': "",
        'posts': [],
        'actions': [],
        'subscribers': [],
        'approved':
            true // TODO need to change this after everything will be fine
      });
    } on FirebaseException catch (e) {
      print("Error while adding association to database");
      print(e.message);
    }
  }

  Future<List<AssociationAction>> getActionsByAssociations() async {
    DocumentReference user = _service
        .collection("users")
        .doc('8DcvbXT3K9Y7rslyQ16bryiNoX52'); //TODO: change to connected user
    try {
      DocumentSnapshot snapshot = await user.get();
      List<AssociationAction> actionList = snapshot
          .get('actions')
          .map((e) async => this.getActionByReference(e))
          .toList();
      return actionList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all actions of user");
    }
  }

  Future<List<AssociationAction>> getActionByAssociationReference(
      DocumentReference reference) async {
    Association association =
        await this.getAssociationInfosFromDB(reference.id);
    List<AssociationAction> actionList = [];
    if (association.actions!.length == 0) {
      return actionList;
    }

    association.actions?.forEach((e) => {
          actionList.add(AssociationAction(
              e.hashCode.toString(),
              e['title'],
              e['city'],
              e['postalCode'],
              e['address'],
              e['description'],
              e['type'],
              e['startDate'],
              e['endDate'],
              association))
        });
    return actionList;
  }

  Future<List<AssociationAction>> getUserAssociationsByDate() async {
    DocumentReference user = _service
        .collection("users")
        .doc('8DcvbXT3K9Y7rslyQ16bryiNoX52'); //TODO: change to connected user
    try {
      DocumentSnapshot snapshot = await user.get();
      List associationList = snapshot.get('subscriptions').toList();
      List<AssociationAction> actionList = [];
      for (var reference in associationList) {
        List<AssociationAction> newActionList =
            await this.getActionByAssociationReference(reference);
        actionList = actionList + newActionList;
      }
      actionList.sort((a, b) => a.startDate.compareTo(b.startDate));
      return actionList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all actions of user");
    }
  }

  //TODO: Watch out, never tested
  addActionToUser(AssociationAction action, User user) async {
    DocumentReference documentUser = _service.collection("users").doc(user.uid);
    List<String> reference = ["/actions/${action.id}"];
    try {
      await documentUser.update({"actions": FieldValue.arrayUnion(reference)});
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while adding action to user");
    }
  }

  Future<AssociationAction> getActionByReference(
      DocumentReference reference) async {
    DocumentReference associationAction =
        _service.doc('actions/${reference.id.toString()}');
    try {
      DocumentSnapshot snapshot = await associationAction.get();
      return AssociationAction(
          snapshot.id,
          snapshot.get('title'),
          snapshot.get('city'),
          snapshot.get('postalCode'),
          snapshot.get('address'),
          snapshot.get('description'),
          snapshot.get('type'),
          snapshot.get('startDate'),
          snapshot.get('endDate'),
          await this.getAssociationInfosFromDB(snapshot.get("assosId")));
    } on FirebaseException catch (e) {
      return Future.error("Error while resolving action");
    }
  }

  //TODO: Watch out, never tested
  Future<List<AssociationAction>> getAllAssociationActions() async {
    CollectionReference actions = _service.collection("actions");
    try {
      QuerySnapshot snapshot = await actions.get();
      List<AssociationAction> actionList = snapshot.docs
          .map((e) async => {
                this
                    .getAssociationInfosFromDB(e.get("association"))
                    .then((association) => {
                          AssociationAction(
                              e.id,
                              e.get("title"),
                              e.get("city"),
                              e.get("postalCode"),
                              e.get("address"),
                              e.get("description"),
                              e.get("type"),
                              e.get("startDate"),
                              e.get("endDate"),
                              association)
                        })
              })
          .cast<AssociationAction>()
          .toList();
      return actionList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all actions of user");
    }
  }

  @override
  Future<List<Association>> getSubscribedAssociationByUser(String uid) async {
    CollectionReference associations = _service.collection("associations");
    try {
      final snapshot =
          await associations.where("subscribers", arrayContains: uid).get();
      List<Association> _subAssosList = snapshot.docs
          .map((e) => Association(
              e.id,
              e.get("name"),
              e.get("description"),
              e.get("mail"),
              e.get("address"),
              e.get("city"),
              e.get("postalCode"),
              e.get("phone"),
              e.get("banner"),
              e.get("president"),
              e.get("approved"),
              e.get("type"),
              e.get("posts"),
              e.get("actions"),
              e.get("subscribers")))
          .toList();
      return _subAssosList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all associations");
    }
  }
}
