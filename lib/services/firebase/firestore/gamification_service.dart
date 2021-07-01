import 'package:assosnation_app/services/models/gamification.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../interfaces/gamification_interface.dart';

class GamificationService extends GamificationInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future<DocumentReference> initGamificationForUser(String userId) async {
    try {
      DocumentReference userRef = _service.collection("users").doc(userId);
      CollectionReference gamification = _service.collection("gamification");

      DocumentReference docRef = await gamification.add({
        "level": 1,
        "exp": 0,
        "likeNumber": 0,
        "loginCount": 0,
        "subCount": 0,
        "eventRegistrations": 0,
        "user": {"id": userId, "ref": userRef},
      });

      return docRef;
    } on FirebaseException catch (e) {
      return Future.error("Cannot init gamification infos for that user");
    }
  }

  @override
  Future<Gamification> getGamificationInfos(String userId) async {
    try {
      DocumentReference userRef = _service.collection("users").doc(userId);

      final userInfos = await userRef.get();

      DocumentReference gamiRef = _service
          .collection("gamification")
          .doc(userInfos.get("gamificationId"));

      final response = await gamiRef.get();
      Gamification gamification = Gamification.withInfos(
          user: response.get("user"),
          level: response.get("level"),
          exp: response.get("exp"),
          likeNumber: response.get("likeNumber"),
          loginCount: response.get("loginCount"),
          subCount: response.get("subCount"),
          eventRegistrations: response.get("eventRegistrations"));

      return gamification;
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot retrieve gamification infos for that reference");
    }
  }

  @override
  int computeExp(
      int likesNumber, int loginCount, int subCount, int eventRegistrations) {
    int likeTotalXp = likesNumber * Constants.likeCountExpValue;
    int loginTotalXp = loginCount * Constants.loginCountExpValue;
    int subTotalXp = subCount * Constants.subCountExpValue;
    int eventRegistrationsTotalXp =
        eventRegistrations * Constants.eventRegistrationsExpValue;
    return likeTotalXp + loginTotalXp + subTotalXp + eventRegistrationsTotalXp;
  }

  @override
  int computeLevel(int exp) {
    if (exp == 0)
      return 1;
    else {
      int computedLevel = (exp / Constants.xpToLevelMultiplier).round();
      if (computedLevel <= 1)
        return 1;
      else
        return (exp / Constants.xpToLevelMultiplier).round();
    }
  }

  @override
  Future increaseLikeNumberByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      await gamiRef.update({"likeNumber": FieldValue.increment(1)});
      await updateExpAndLevel(gamificationId);
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot increase likeNumber for that reference");
    }
  }

  @override
  Future increaseLoginCountByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      await gamiRef.update({"loginCount": FieldValue.increment(1)});
      await updateExpAndLevel(gamificationId);
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot increase loginCount for that reference");
    }
  }

  @override
  Future decreaseLikeNumberByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);
      final gamiInfos = await gamiRef.get();
      await gamiRef.update({"likeNumber": gamiInfos.get("likeNumber") - 1});
      await updateExpAndLevel(gamificationId);
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot decrease likeNumber for that reference");
    }
  }

  @override
  Future decreaseLoginCountByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      final gamiInfos = await gamiRef.get();
      await gamiRef.update({"loginCount": gamiInfos.get("loginCount") - 1});
      await updateExpAndLevel(gamificationId);
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot decrease loginCount for that reference");
    }
  }

  @override
  Stream<DocumentSnapshot> watchGamificationInfos(String gamificationId) {
    DocumentReference gamiRef =
        _service.collection("gamification").doc(gamificationId);
    return gamiRef.snapshots();
  }

  @override
  Future updateExpAndLevel(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      final gamiInfos = await gamiRef.get();
      int totalExp = computeExp(
        gamiInfos.get("likeNumber"),
        gamiInfos.get("loginCount"),
        gamiInfos.get("subCount"),
        gamiInfos.get("eventRegistrations"),
      );

      int computedLevel = computeLevel(totalExp);
      await gamiRef.update({
        "exp": totalExp,
        "level": computedLevel,
      });
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot update experience for the gamification document $gamificationId");
    }
  }

  @override
  Future decreaseSubCountByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      final gamiInfos = await gamiRef.get();
      await gamiRef.update({"subCount": gamiInfos.get("subCount") - 1});
      await updateExpAndLevel(gamificationId);

      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot decrease subCount for that reference");
    }
  }

  @override
  Future increaseSubCountByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      await gamiRef.update({"subCount": FieldValue.increment(1)});
      await updateExpAndLevel(gamificationId);

      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot increase subCount for that reference");
    }
  }

  @override
  Future decreaseEventRegistrationByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      final gamiInfos = await gamiRef.get();
      await gamiRef.update(
          {"eventRegistrations": gamiInfos.get("eventRegistrations") - 1});
      await updateExpAndLevel(gamificationId);

      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot decrease eventRegistrations for that reference");
    }
  }

  @override
  Future increaseEventRegistrationByOne(String gamificationId) async {
    try {
      DocumentReference gamiRef =
          _service.collection("gamification").doc(gamificationId);

      await gamiRef.update({"eventRegistrations": FieldValue.increment(1)});
      await updateExpAndLevel(gamificationId);

      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot increase eventRegistrations for that reference");
    }
  }
}
