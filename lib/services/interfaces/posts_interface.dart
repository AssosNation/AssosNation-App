import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';

abstract class PostsInterface {
  Future createPostForAssociation(Post post, Association association);
  Future removePost(String postId);
  Future<List<Post>> retrieveAllPostsForAssociation(Association association);
  Future updatePost(Post post, String title, String content);
}
