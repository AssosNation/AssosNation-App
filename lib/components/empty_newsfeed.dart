import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/material.dart';

class EmptyNewsFeed extends StatelessWidget {
  const EmptyNewsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.no_posts_msg_part1,
            style:
                TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
          ),
          Text(AppLocalizations.of(context)!.no_posts_msg_part2,
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor)),
        ],
      ),
    );
  }
}
