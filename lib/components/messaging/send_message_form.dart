import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMessageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor.withAlpha(2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Form(
                  child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ))),
          IconButton(
              icon: Icon(
                Icons.send,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
