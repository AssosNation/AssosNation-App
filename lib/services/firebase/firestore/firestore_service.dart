import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService extends FirestoreServiceInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future<List<dynamic>> getAllPostsByAssociationList(
      List? associationList) async {
    if (associationList == null) {
      return List.empty();
    }

    Map<DocumentReference, String> associationNameList =
        await getAssociationListName(associationList);

    CollectionReference posts = _service.collection("posts");
    try {
      QuerySnapshot snapshot =
          await posts.orderBy("timestamp", descending: true).get();
      List postList = List.empty(growable: true);
      snapshot.docs.forEach((post) async {
        if (associationList.contains(post.get('assosId'))) {
          postList.add({
            "post": Post(
                post.id,
                post.get('title'),
                post.get('assosId'),
                post.get('content'),
                post.get('photo'),
                post.get('timestamp'),
                post.get('usersWhoLiked')),
            "assosName": associationNameList[post.get('assosId')]
          });
        }
      });

      return postList;
    } on FirebaseException catch (e) {
      return Future.error("Error while retrieving all posts");
    }
  }

  @override
  Future<Map<DocumentReference, String>> getAssociationListName(
      associationList) async {
    Map<DocumentReference, String> associationNameList = {};
    for (DocumentReference association in associationList) {
      DocumentSnapshot assosRef = await association.get();
      associationNameList[association] = assosRef.get('name');
    }

    return associationNameList;
  }

  @override
  Future<Association> getAssociationInfosFromDBWithReference(
      DocumentReference association) async {
    return this.getAssociationInfosFromDB(association.id);
  }

  @override
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
          snapshot.get("actions"),
          snapshot.get("subscribers"));
      return assos;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving association data");
    }
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

  @override
  Future<List<AssociationAction>> getActionByAssociationReference(
      DocumentReference reference, _userId) async {
    Association association =
        await this.getAssociationInfosFromDB(reference.id);
    return this.getActionsByAssociation(association, _userId);
  }

  @override
  Future<List<AssociationAction>> getAllActions(_userId) async {
    try {
      List<Association> associationList = await this.getAllAssociations();
      List<AssociationAction> actionList = [];
      for (var association in associationList) {
        List<AssociationAction> newActionList =
            this.getActionsByAssociation(association, _userId);
        actionList = actionList + newActionList;
      }
      actionList.sort((a, b) => a.startDate.compareTo(b.startDate));
      return actionList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all actions");
    }
  }

  @override
  List<AssociationAction> getActionsByAssociation(
      Association association, _userId) {
    List<AssociationAction> actionList = [];
    if (association.actions!.length == 0) {
      return actionList;
    }

    association.actions?.asMap().forEach((index, e) => {
          actionList.add(AssociationAction(
              index,
              e['title'],
              e['city'],
              e['postalCode'],
              e['address'],
              e['description'],
              e['type'],
              e['startDate'],
              e['endDate'],
              association,
              e['usersRegistered'].length,
              e['usersRegistered'].contains(_userId)))
        });

    return actionList;
  }

  @override
  Future<List<AssociationAction>> getUserAssociationsByDate(_userId) async {
    DocumentReference user = _service.collection("users").doc(_userId);
    try {
      DocumentSnapshot snapshot = await user.get();
      List associationList = snapshot.get('subscriptions').toList();
      List<AssociationAction> actionList = [];
      for (var reference in associationList) {
        List<AssociationAction> newActionList =
            await this.getActionByAssociationReference(reference, _userId);
        actionList = actionList + newActionList;
      }
      actionList.sort((a, b) => a.startDate.compareTo(b.startDate));

      return actionList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all actions of user");
    }
  }

  @override
  Future<List<Association>> getSubscribedAssociationsByUser(AnUser user) async {
    CollectionReference associations = _service.collection("associations");
    DocumentReference documentUser = _service.collection("users").doc(user.uid);
    try {
      final snapshot = await associations
          .where("subscribers", arrayContains: documentUser)
          .get();
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
              e.get("actions"),
              e.get("subscribers")))
          .toList();
      return _subAssosList;
    } on FirebaseException catch (e) {
      print(e.message);
      return Future.error("Error while retrieving all associations");
    }
  }

  @override
  Future<List<AssociationAction>> getAllActionsByAssociation(
      Association assos, AnUser user) async {
    List<AssociationAction> actionsList = [];

    assos.actions?.asMap().forEach((index, e) => {
          actionsList.add(AssociationAction(
              index,
              e['title'],
              e['city'],
              e['postalCode'],
              e['address'],
              e['description'],
              e['type'],
              e['startDate'],
              e['endDate'],
              assos,
              e['usersRegistered'].length,
              e['usersRegistered'].contains(user.uid)))
        });
    return actionsList;
  }

  @override
  Future<DocumentReference> getAssociationReference(String assosId) async {
    DocumentReference assosRef =
        _service.collection("associations").doc(assosId);
    return assosRef;
  }

  @override
  Future updateAssociationBanner(String assosId, String imgUrl) async {
    try {
      DocumentReference userRef =
          _service.collection("associations").doc(assosId);
      await userRef.update({"banner": imgUrl});

      return true;
    } on FirebaseException catch (e) {
      Future.error("Couldn't change user's profile image");
    }
  }
}
