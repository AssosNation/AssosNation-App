import 'package:assosnation_app/components/posts/association_post_card.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/converters.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostManagement extends StatelessWidget {
  const PostManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Text(AppLocalizations.of(context)!.post_management_main_title,
            style: Theme.of(context).textTheme.headline3),
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: PostService()
                .retrieveAllPostsForAssociationStream(_association!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final List<Post> docs =
                      Converters.convertDocSnapshotsToListPost(
                          snapshot.data!.docs);
                  return ListView.builder(
                    itemCount: docs.length,
                    shrinkWrap: true,
                    cacheExtent: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: AssociationPostCard(docs[index]),
                      );
                    },
                  );
                }
              }
              return Container();
            }),
      ),
    ]);
  }
}
