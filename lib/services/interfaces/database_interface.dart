abstract class DatabaseInterface {
  Future getAssociationsList();
  Future getAllUsers();
  Future getAllPostsByAssociation();
  Future getAllConversations();
  Future getAllMessagesByConversation();
  Future addUserToDB(user);
  Future getUserInfosFromDB(uid);
  Future removeUserFromDB(uid);
}
