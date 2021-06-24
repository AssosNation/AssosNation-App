import 'package:assosnation_app/services/firebase/firestore/posts/posts_service.dart';
import 'package:flutter/material.dart';

class DeletePostConfirmationDialog extends StatelessWidget {
  const DeletePostConfirmationDialog(this.confirmationMessage, this.postId);

  final String? confirmationMessage;
  final String postId;

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
                  onPressed: () async {
                    await PostService().removePost(postId);
                    Navigator.pop(context);
                  },
                  child: Text("Delete", style: TextStyle(color: Colors.red))),
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.teal),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
