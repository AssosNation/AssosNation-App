import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMessageForm extends StatefulWidget {
  SendMessageForm(this.convId, this.sender);

  final String convId;
  final DocumentReference sender;

  @override
  _SendMessageFormState createState() => _SendMessageFormState();
}

class _SendMessageFormState extends State<SendMessageForm> {
  final _formKey = GlobalKey<FormState>();
  late String _msgToSend;

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        await MessagingService().sendMessageToConversation(
            widget.convId, widget.sender, _msgToSend);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (msg) {
                          if (msg!.isNotEmpty) {
                            _msgToSend = msg;
                            return null;
                          } else
                            return "This field cannot be empty";
                        },
                      ),
                    ))),
            IconButton(
                icon: Icon(
                  Icons.send_sharp,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: _verifyAndValidateForm),
          ],
        ),
      ),
    );
  }
}
