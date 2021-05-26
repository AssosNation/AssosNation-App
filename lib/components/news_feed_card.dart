import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsFeedCard extends StatelessWidget {
  final _post;

  NewsFeedCard(this._post);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
          child: Row(
            children: [
              Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(this._post.title)
                      ],
                    ),
                    Row(
                      children: [
                        Text(this._post.content)
                      ],
                    ),
                    Row(
                        children: [
                          Text(this._post.likesNumber.toString())
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
