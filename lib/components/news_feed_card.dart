import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsFeedCard extends StatelessWidget {
  final _post;

  NewsFeedCard(this._post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(this._post.title),
                    Text(this._post.title),
                    Text(this._post.title)
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                        "https://media-exp1.licdn.com/dms/image/C5603AQG8R8Nn1Ghfog/profile-displayphoto-shrink_200_200/0/1530535669298?e=1626307200&v=beta&t=2-vwdj9T-o48WDBgn5I4m8Fw-FwifUJrJor-nzbTZh4")
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(this._post.content),
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.whatshot_outlined),
                        label: Text("Like")),
                    Text(this._post.likesNumber.toString())
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
