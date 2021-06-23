import 'package:assosnation_app/components/association_post_card.dart';
import 'package:assosnation_app/services/firebase/firestore/posts/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostManagement extends StatelessWidget {
  const PostManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();

    return Container(
        child: FutureBuilder(
      future: PostService().retrieveAllPostsForAssociation(_association!),
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AssociationPostCard(snapshot.data![index]),
              );
            },
          );
        } else
          return Container();
      },
    ));
  }
}
