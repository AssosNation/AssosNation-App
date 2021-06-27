import 'package:assosnation_app/components/posts/association_post_card.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostManagement extends StatelessWidget {
  const PostManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Column(children: [
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: PostService()
                .retrieveAllPostsForAssociationStream(_association!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<Post> docs =
                    Converters.convertDocSnapshotsToListPost(
                        snapshot.data!.docs);
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: AssociationPostCard(docs[index]),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    ]);
  }
}
