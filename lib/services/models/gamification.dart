class Gamification {
  Object user;
  int level = 1;
  int exp = 0;
  int likeNumber = 0;
  int loginCount = 0;

  Gamification({required this.user});

  Gamification.withInfos(
      {required this.user,
      required this.level,
      required this.exp,
      required this.likeNumber,
      required this.loginCount});
}
