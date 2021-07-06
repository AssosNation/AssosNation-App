import 'package:assosnation_app/services/models/gamification.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/material.dart';

class GamificationInfosDialog extends StatelessWidget {
  final Gamification gamification;

  const GamificationInfosDialog({Key? key, required this.gamification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.gamification_info_title,
          style:
              TextStyle(fontSize: 20, color: Theme.of(context).primaryColor)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              AppLocalizations.of(context)!
                  .gamification_info_xpamount("${gamification.exp}"),
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${AppLocalizations.of(context)!.gamification_info_xpbefore("${Constants.xpToLevelMultiplier - (gamification.exp % Constants.xpToLevelMultiplier)}")}",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${AppLocalizations.of(context)!.gamification_info_likes("${Constants.loginCountExpValue}")}",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${AppLocalizations.of(context)!.gamification_info_connections("${Constants.loginCountExpValue}")}",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${AppLocalizations.of(context)!.gamification_info_subs("${Constants.subCountExpValue}")}",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            Text(
              "${AppLocalizations.of(context)!.gamification_info_events("${Constants.eventRegistrationsExpValue}")}",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        Center(
            child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
                label: Text(AppLocalizations.of(context)!.close_label)))
      ],
    );
  }
}
