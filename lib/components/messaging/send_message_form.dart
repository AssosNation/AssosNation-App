import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMessageForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _service = FireStoreService();

  String _msgToSend = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        //dynamic res = await _auth.send
        print(_msgToSend);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 5, 5, 10),
      child: Card(
        elevation: 5.0,
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
                  Icons.send,
                ),
                onPressed: _verifyAndValidateForm),
          ],
        ),
      ),
    );
  }
}
