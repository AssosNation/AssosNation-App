import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GamificationInterface {
  Future<DocumentReference> initGamificationForUser(String userId);

  Future getGamificationInfos(String gamificationId);

  int computeLevel(int exp);

  int computeExp(
    int likesNumber,
    int loginCount,
    int subCount,
  );

  Future increaseLikeNumberByOne(String gamificationId);

  Future increaseLoginCountByOne(String gamificationId);

  Future decreaseLikeNumberByOne(String gamificationId);

  Future decreaseLoginCountByOne(String gamificationId);

  Stream<DocumentSnapshot> watchGamificationInfos(String gamificationId);

  Future updateExpAndLevel(String gamificationId);

  Future increaseSubCountByOne(String gamificationId);

  Future decreaseSubCountByOne(String gamificationId);
}
