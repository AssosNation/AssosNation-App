import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostsInterface {
  Future createPostForAssociation(Post post, String assosId);

  Stream<QuerySnapshot> retrieveAllPostsForAssociationStream(Association assos);

  Future removePost(String postId);
  Future<List<Post>> retrieveAllPostsForAssociation(Association association);
  Future updatePost(Post post, String title, String content);
}
