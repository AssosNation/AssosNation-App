import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/material.dart';

import 'package:assosnation_app/components/news_feed_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                  future: FireStoreService().getAllPostsByAssociation(),
                  builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                    if(snapshot.hasData) {
                      List<Post> postList = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => Expanded(child: NewsFeedCard(postList[index])),
                          itemCount: postList.length,
                          shrinkWrap: true,
                        ),
                      );
                    } else {
                      return Text("Pas de news pour toi l'ami");
                    }
                  },
                ),

              ],
            ),

          )

        ],
      ),
    );
  }
}

/*


 */
