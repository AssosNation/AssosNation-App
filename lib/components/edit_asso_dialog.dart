import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/services/firebase/firestore/association_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAssoDialog extends StatefulWidget {
  final Association _association;
  final String _field;

  EditAssoDialog(this._association, this._field);

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
        if (widget._field == "name") {
          res = await AssociationService()
              .updateName(widget._association, _content);
        } else if (widget._field == "phone") {
          res = await AssociationService()
              .updatePhone(widget._association, _content);
        } else if (widget._field == "address") {
          res = await AssociationService()
              .updateAddress(widget._association, _content);
        } else if (widget._field == "city") {
          res = await AssociationService()
              .updateCity(widget._association, _content);
        } else if (widget._field == "description") {
          res = await AssociationService()
              .updateDescription(widget._association, _content);
        }
        if (res == true) {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(context,
              AppLocalizations.of(context)!.infos_updated, Colors.green);
        } else {
          Navigator.pop(context);
          Utils.displaySnackBarWithMessage(context,
              AppLocalizations.of(context)!.error_no_infos, Colors.red);
        }
      }
    }
  }

  _displayCurrentContent() {
    if (widget._field == "name") {
      return widget._association.name;
    } else if (widget._field == "phone") {
      return widget._association.phone;
    } else if (widget._field == "address") {
      return widget._association.address;
    } else if (widget._field == "city") {
      return widget._association.city;
    } else if (widget._field == "description") {
      return widget._association.description;
    } else {
      return "";
    }
  }

  _selectMaxLines() {
    if (widget._field == "description") {
      return 4;
    } else {
      return 1;
    }
  }

  _selectMaxCharacters() {
    if (widget._field == "description") {
      return 150;
    } else if (widget._field == "phone") {
      return 10;
    } else {
      return 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostMainSubtitle(AppLocalizations.of(context)!.content_label),
                  Expanded(
                    child: TextFormField(
                      maxLength: _selectMaxCharacters(),
                      autocorrect: true,
                      initialValue: _displayCurrentContent(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (content) {
                        if (content!.isNotEmpty) {
                          _content = content;
                          return null;
                        } else
                          return "This field cannot be empty nor the same value as before";
                      },
                      maxLines: _selectMaxLines(),
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
                          AppLocalizations.of(context)!.cancel_button_label,
                          style: TextStyle(color: Colors.red))),
                  OutlinedButton(
                      onPressed: _verifyAndValidateForm,
                      child: Text(
                        AppLocalizations.of(context)!.confirm_button_label,
                        style: TextStyle(color: Colors.teal),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
