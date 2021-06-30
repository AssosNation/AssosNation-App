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
        "exp": 1,
        "likeNumber": 1,
        "loginCount": 1,
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
          loginCount: response.get("loginCount"));

      return gamification;
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot retrieve gamification infos for that reference");
    }
  }

  @override
  int computeExp(int likesNumber, int loginCount) {
    int likeTotalXp = likesNumber * Constants.likeCountExpValue;
    int loginTotalXp = loginCount * Constants.loginCountExpValue;
    return likeTotalXp + loginTotalXp;
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
      int totalExp =
          computeExp(gamiInfos.get("likeNumber"), gamiInfos.get("loginCount"));
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
}
