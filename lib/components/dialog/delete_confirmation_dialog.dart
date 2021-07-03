import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/material.dart';

class DeleteObjectConfirmationDialog extends StatelessWidget {
  const DeleteObjectConfirmationDialog(
      this.confirmationMessage, this.postId, this.action);

  final String? confirmationMessage;
  final String? postId;
  final AssociationAction? action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                confirmationMessage!,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.cancel_button_label,
                    style: TextStyle(color: Colors.teal),
                  )),
              OutlinedButton(
                  onPressed: () async {
                    if (this.postId != null) {
                      await PostService().removePost(this.postId!);
                    } else {
                      AssociationActionsService()
                          .removeAssociationAction(this.action!);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.delete_button,
                      style: TextStyle(color: Colors.red))),
            ],
          )
        ],
      ),
    );
  }
}
