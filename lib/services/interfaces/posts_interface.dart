import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';

abstract class PostsInterface {
  Future createPostForAssociation(Post post, Association association);
  Future removePostForAssociation(Post post, Association association);
  Future retrieveAllPostsForAssociation(Association association);
  Future updatePostForAssociation(Post post, Association association);
}
