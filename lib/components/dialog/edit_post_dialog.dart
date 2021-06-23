import 'package:assosnation_app/services/models/post.dart';
import 'package:flutter/material.dart';

class EditPostDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Post _post;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  EditPostDialog(this._post) {
    _titleController.text = _post.title;
    _contentController.text = _post.content;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Title : "),
            Expanded(
              child: TextFormField(
                maxLines: 1,
                controller: _titleController,
                focusNode: FocusNode(),
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.red,
              ),
            ),
            Text("Content : "),
            Expanded(
              child: TextFormField(
                maxLines: 7,
                controller: _contentController,
                focusNode: FocusNode(),
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.red,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(onPressed: () {}, child: Text("Validate")),
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
