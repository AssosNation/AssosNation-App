import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GamificationInterface {
  Future getCurrentLevel(String gamificationId);

  Future getCurrentExp(String gamificationId);

  Future getGamificationInfos(String gamificationId);

  int computeLevel(int exp);

  int computeExp(
    int likesNumber,
    int loginCount,
  );

  Future increaseLikeNumberByOne(String gamificationId);

  Future increaseLoginCountByOne(String gamificationId);

  Future decreaseLikeNumberByOne(String gamificationId);

  Future decreaseLoginCountByOne(String gamificationId);

  Stream<DocumentSnapshot> watchGamificationInfos(String gamificationId);

  Future updateLevel(String gamificationId);

  Future updateExp(String gamificationId);
}
