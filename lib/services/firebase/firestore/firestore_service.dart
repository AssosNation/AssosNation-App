import 'package:assosnation_app/services/interfaces/database_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService extends DatabaseInterface {

  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  void getAllConversations() {
    // TODO: implement getAllConversations
  }

  @override
  void getAllMessagesByConversation() {
    // TODO: implement getAllMessagesByConversation
  }

  @override
  void getAllPostsByAssociation() {
    // TODO: implement getAllPostsByAssociation
  }

  @override
  void getAllUsers() {
    // TODO: implement getAllUsers
  }

  @override
  void getAssociationsList() {
    // TODO: implement getAssociationsList
  }


  
}