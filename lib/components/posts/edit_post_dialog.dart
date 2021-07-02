import 'dart:io';

import 'package:assosnation_app/components/forms/form_subtitle.dart';
import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../no_image_placeholder.dart';

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
  File? _updatedImage;

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res =
            await PostService().updatePost(widget._post, _title, _content);
        if (_updatedImage != null)
          await StorageService()
              .uploadPostImageToStorage(_updatedImage!, widget._post.id);
        if (res == true) {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(
              context, "Your post has been updated", Colors.green);
        } else {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(context,
              "Something wrong happened, please try again", Colors.red);
        }
      }
    }
  }

  Widget _displaySelectedImage() {
    if (_updatedImage != null) {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Image.file(
            _updatedImage!,
            fit: BoxFit.fill,
          ));
    } else if (widget._post.photo != "") {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            widget._post.photo,
            fit: BoxFit.fill,
          ));
    } else {
      return NoImagePlaceholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FormSubTitle("Image : "),
                    Expanded(
                      child: InkWell(
                        splashColor: Theme.of(context).accentColor,
                        onTap: () async {
                          final img =
                              await StorageService().selectImageFromGallery();
                          setState(() {
                            _updatedImage = img;
                          });
                        },
                        child: Stack(
                          children: [
                            _displaySelectedImage(),
                            Positioned.fill(
                                child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Theme.of(context).accentColor,
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
