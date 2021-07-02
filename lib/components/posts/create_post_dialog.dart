import 'dart:io';

import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/components/forms/form_subtitle.dart';
import 'package:assosnation_app/components/no_image_placeholder.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/firebase/storage/storage_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostDialog extends StatefulWidget {
  @override
  _CreatePostDialogState createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _content = "";
  File? _image;

  _verifyAndValidateForm(assosId) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        final postToCreate = Post.creation(_title, assosId, _content);
        final DocumentReference postRef =
            await PostService().createPostForAssociation(postToCreate, assosId);
        await StorageService().uploadPostImageToStorage(_image!, postRef.id);
        if (postRef is DocumentReference) {
          Navigator.pop(context);
          setState(() {
            Utils.displaySnackBarWithMessage(
                context, "Your post has been updated", Colors.green);
          });
        } else {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(context,
              "Something wrong happened, please try again", Colors.red);
        }
      }
    }
  }

  Widget _displaySelectedImage() {
    if (_image != null) {
      return Image.file(
        _image!,
        fit: BoxFit.fill,
      );
    } else {
      return NoImagePlaceholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _assos = context.watch<Association?>();
    return SingleChildScrollView(
      child: Dialog(
        insetPadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FormMainTitle("Creating a post"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormSubTitle(
                          "${AppLocalizations.of(context)!.title_label} : "),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          maxLength: 30,
                          autocorrect: true,
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
                              _image = img;
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
                      FormSubTitle(
                          "${AppLocalizations.of(context)!.content_label} : "),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          maxLength: 150,
                          autocorrect: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (content) {
                            if (content!.isNotEmpty) {
                              _content = content;
                              return null;
                            } else
                              return "This field cannot be empty nor the same value as before";
                          },
                          maxLines: 3,
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
                          child: Text(
                              "${AppLocalizations.of(context)!.cancel_button_label.toUpperCase()}",
                              style: TextStyle(color: Colors.red))),
                      OutlinedButton(
                          onPressed: () async {
                            _verifyAndValidateForm(_assos!.uid);
                          },
                          child: Text(
                            "${AppLocalizations.of(context)!.confirm_button_label.toUpperCase()}",
                            style: TextStyle(color: Colors.teal),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
