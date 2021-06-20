import 'package:assosnation_app/services/interfaces/posts_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService implements PostsInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future createPostForAssociation(Post post, Association association) async {
    DocumentReference assosRef =
        _service.collection("associations").doc(association.uid);
    CollectionReference posts = _service.collection("posts");
    try {
      final post = await posts.where("assosId", isEqualTo: assosRef).get();
    } on FirebaseException catch (e) {
      Future.error("Cannot create post for association ${association.name}");
    }
  }

  @override
  Future removePostForAssociation(Post post, Association association) {
    // TODO: implement removePostForAssociation
    throw UnimplementedError();
  }

  @override
  Future retrieveAllPostsForAssociation(Association association) async {
    DocumentReference assosRef =
        _service.collection("associations").doc(association.uid);
    CollectionReference postsRef = _service.collection("posts");
    try {
      final posts = await postsRef.where("assosId", isEqualTo: assosRef).get();

      List<Post> postList = posts.docs
          .map((e) => Post(
              e.id,
              e.get("title"),
              e.get("assosId").toString(),
              e.get("content"),
              e.get("photo"),
              e.get("timestamp"),
              e.get("usersWhoLiked")))
          .toList();
      return postList;
    } on FirebaseException catch (e) {
      Future.error(
          "Cannot retrieve all post for association ${association.name}");
    }
  }

  @override
  Future updatePostForAssociation(Post post, Association association) {
    // TODO: implement updatePostForAssociation
    throw UnimplementedError();
  }
}
