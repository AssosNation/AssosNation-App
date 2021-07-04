import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 50,
      title: Icon(
        Icons.info_outline_rounded,
        color: Colors.redAccent,
        size: 55,
      ),
      content: Text(AppLocalizations.of(context)!.are_you_sure),
      actions: [
        CupertinoButton(
          child: Text(AppLocalizations.of(context)!.yes),
          onPressed: () {
            final _auth = FirebaseAuth.instance;
            _auth.signOut();
            Navigator.of(context).pop();
          },
        ),
        CupertinoButton(
          child: Text(
            AppLocalizations.of(context)!.no,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
