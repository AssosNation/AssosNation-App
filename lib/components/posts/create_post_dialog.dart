import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/components/forms/form_subtitle.dart';
import 'package:assosnation_app/services/firebase/firestore/posts_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/utils.dart';
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

  _verifyAndValidateForm(assosId) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        final postToCreate = Post.creation(_title, assosId, _content, "");
        final res =
            await PostService().createPostForAssociation(postToCreate, assosId);
        if (res == true) {
          Navigator.pop(context);
          setState(() {
            _title = "";
            _content = "";
            Utils.displaySnackBarWithMessage(context,
                AppLocalizations.of(context)!.post_updated, Colors.green);
          });
        } else {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(context,
              AppLocalizations.of(context)!.error_no_infos, Colors.red);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _assos = context.watch<Association?>();
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(0, 50, 0, 50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FormMainTitle(AppLocalizations.of(context)!.post_creating),
                Row(
                  children: [
                    FormSubTitle(
                        "${AppLocalizations.of(context)!.title_label} : "),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (title) {
                          if (title!.isNotEmpty) {
                            _title = title;
                            return null;
                          } else
                            return AppLocalizations.of(context)!
                                .error_empty_field;
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
                    FormSubTitle(
                        "${AppLocalizations.of(context)!.content_label} : "),
                    Expanded(
                      child: TextFormField(
                        maxLength: 150,
                        autocorrect: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (content) {
                          if (content!.isNotEmpty) {
                            _content = content;
                            return null;
                          } else
                            return AppLocalizations.of(context)!
                                .error_empty_field;
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
    );
  }
}
