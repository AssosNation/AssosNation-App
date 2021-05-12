abstract class DatabaseInterface {
  Future getAllAssociations();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future getAllConversations();
  Future getAllMessagesByConversation();
  Future addUserToDB(user);
  Future getUserInfosFromDB(uid);
  Future removeUserFromDB(uid);
}
