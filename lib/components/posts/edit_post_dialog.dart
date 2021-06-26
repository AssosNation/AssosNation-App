import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/cupertino.dart';
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
          _displaySnackBarWithMessage(
              "Your post has been updated", Colors.green);
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
                PostMainTitle("Editing post"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PostMainSubtitle("Title : "),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostMainSubtitle("Content : "),
                    Expanded(
                      child: TextFormField(
                        maxLength: 150,
                        autocorrect: true,
                        initialValue: widget._post.content,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (content) {
                          if (content!.isNotEmpty) {
                            _content = content;
                            return null;
                          } else
                            return "This field cannot be empty nor the same value as before";
                        },
                        maxLines: 2,
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
