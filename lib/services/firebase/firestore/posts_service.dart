import 'package:assosnation_app/services/interfaces/posts_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService implements PostsInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  Future createPostForAssociation(Post post, String assosId) async {
    DocumentReference assosRef =
        _service.collection("associations").doc(assosId);
    CollectionReference posts = _service.collection("posts");
    try {
      DocumentReference postRef = await posts.add({
        "assosId": assosRef,
        "title": post.title,
        "content": post.content,
        "photo": "",
        "timestamp": Timestamp.now(),
        "usersWhoLiked": []
      });
      return postRef;
    } on FirebaseException catch (e) {
      Future.error("Cannot create post for association $assosRef");
    }
  }

  @override
  Future removePost(String postId) async {
    DocumentReference postRef = _service.collection("posts").doc(postId);
    try {
      await postRef.delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update post with id $postId");
    }
  }

  Stream<QuerySnapshot> retrieveAllPostsForAssociationStream(
      Association assos) {
    DocumentReference assosRef =
        _service.collection("associations").doc(assos.uid);
    CollectionReference postsRef = _service.collection("posts");
    return postsRef
        .where("assosId", isEqualTo: assosRef)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  @override
  Future<List<Post>> retrieveAllPostsForAssociation(
      Association association) async {
    DocumentReference assosRef =
        _service.collection("associations").doc(association.uid);
    CollectionReference postsRef = _service.collection("posts");
    try {
      final posts = await postsRef.where("assosId", isEqualTo: assosRef).get();

      List<Post> postList = posts.docs
          .map((e) => Post(
              e.id,
              e.get("title"),
              e.get("assosId"),
              e.get("content"),
              e.get("photo"),
              e.get("timestamp"),
              e.get("usersWhoLiked")))
          .toList();
      return postList;
    } on FirebaseException catch (e) {
      return Future.error(
          "Cannot retrieve all post for association ${association.name}");
    }
  }

  @override
  Future updatePost(Post post, String title, String content) async {
    DocumentReference postRef = _service.collection("posts").doc(post.id);
    try {
      await postRef.update({
        "title": title,
        "content": content,
      });
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update post with id ${post.id}");
    }
  }

  Future updatePostImageUrl(String postId, String url) async {
    DocumentReference postRef = _service.collection("posts").doc(postId);
    try {
      await postRef.update({"photo": url});
      return Future.value(true);
    } on FirebaseException catch (e) {
      return Future.error("Cannot update post with id $postId");
    }
  }
}
