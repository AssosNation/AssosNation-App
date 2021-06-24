import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/components/forms/form_subtitle.dart';
import 'package:assosnation_app/services/firebase/firestore/posts/posts_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/material.dart';

class EditPostDialog extends StatefulWidget {
  final Post _post;

  EditPostDialog(this._post);

  @override
  _EditPostDialogState createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _content = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res =
            await PostService().updatePost(widget._post, _title, _content);
        if (res == true) {
          Navigator.pop(context);
          setState(() {
            _title = "";
            _content = "";
            _displaySnackBarWithMessage(
                "Your post has been updated", Colors.green);
          });
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
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FormMainTitle("Updating post informations"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormSubTitle("Title : "),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget._post.title,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (title) {
                          if (title!.isNotEmpty) {
                            _title = title;
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FormSubTitle("Content : "),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget._post.content,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (content) {
                          if (content!.isNotEmpty) {
                            _content = content;
                            return null;
                          } else
                            return "This field cannot be empty nor the same value as before";
                        },
                        maxLines: 10,
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
