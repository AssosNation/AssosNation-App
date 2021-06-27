import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/services/firebase/firestore/asso_details_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAssoDialog extends StatefulWidget {
  final Association _association;
  final String _toto;

  EditAssoDialog(this._association, this._toto);

  @override
  _EditAssoDetailsState createState() => _EditAssoDetailsState();
}

class _EditAssoDetailsState extends State<EditAssoDialog> {
  final _formKey = GlobalKey<FormState>();

  String _content = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res;
        if (widget._toto == "name") {
          res = await AssoDetailsService()
              .updateName(widget._association, _content);
        } else if (widget._toto == "phone") {
          res = await AssoDetailsService()
              .updatePhone(widget._association, _content);
        }
        if (res == true) {
          Navigator.pop(context);
          _displaySnackBarWithMessage(
              "Infos has been updated ! ", Colors.green);
        } else {
          Navigator.pop(context);
          _displaySnackBarWithMessage(
              "Something wrong happened, please try again", Colors.red);
        }
      }
    }
  }

  _displaySnackBarWithMessage(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostMainSubtitle("Content : "),
                    Expanded(
                      child: TextFormField(
                        maxLength: 50,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (content) {
                          if (content!.isNotEmpty) {
                            _content = content;
                            return null;
                          } else
                            return "This field cannot be empty nor the same value as before";
                        },
                        maxLines: 1,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.red))),
                    OutlinedButton(
                        onPressed: _verifyAndValidateForm,
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.teal),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
