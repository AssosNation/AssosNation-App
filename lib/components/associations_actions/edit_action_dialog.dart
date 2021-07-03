import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditActionDialog extends StatefulWidget {
  final AssociationAction _action;

  EditActionDialog(this._action);

  @override
  _EditActionDialogState createState() => _EditActionDialogState();
}

class _EditActionDialogState extends State<EditActionDialog> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _city = "";
  String _address = "";
  String _description = "";
  String _type = "Donation";
  String _postalCode = "";
  Timestamp _startDate = Timestamp.now();
  Timestamp _endDate = Timestamp.now();

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        AssociationAction newAction = AssociationAction(
            0,
            _title,
            _city,
            _postalCode,
            _address,
            _description,
            _type,
            _startDate,
            _endDate,
            this.widget._action.association,
            0,
            false);
        AssociationActionsService()
            .updateAssociationAction(widget._action, newAction);
        Navigator.pop(context);
        _displaySnackBarWithMessage(
            AppLocalizations.of(context)!.post_updated, Colors.green);
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
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PostMainTitle(AppLocalizations.of(context)!.action_edition),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PostMainSubtitle(
                          AppLocalizations.of(context)!.title_label),
                      Expanded(
                        child: TextFormField(
                          maxLength: 30,
                          initialValue: widget._action.title,
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
                      PostMainSubtitle(AppLocalizations.of(context)!.city),
                      Expanded(
                        child: TextFormField(
                          maxLength: 30,
                          autocorrect: true,
                          initialValue: widget._action.city,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (city) {
                            if (city!.isNotEmpty) {
                              _city = city;
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
                      PostMainSubtitle(
                          AppLocalizations.of(context)!.postalcode),
                      Expanded(
                        child: TextFormField(
                          maxLength: 5,
                          autocorrect: true,
                          initialValue: widget._action.postalCode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (postalCode) {
                            if (postalCode!.isNotEmpty) {
                              _postalCode = postalCode;
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
                      PostMainSubtitle(AppLocalizations.of(context)!.address),
                      Expanded(
                        child: TextFormField(
                          maxLength: 50,
                          autocorrect: true,
                          initialValue: widget._action.address,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (address) {
                            if (address!.isNotEmpty) {
                              _address = address;
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
                      PostMainSubtitle(
                          AppLocalizations.of(context)!.description),
                      Expanded(
                        child: TextFormField(
                          maxLength: 150,
                          autocorrect: true,
                          initialValue: widget._action.description,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (description) {
                            if (description!.isNotEmpty) {
                              _description = description;
                              return null;
                            } else
                              return AppLocalizations.of(context)!
                                  .error_empty_field;
                          },
                          maxLines: 2,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PostMainSubtitle(AppLocalizations.of(context)!.type),
                      Expanded(
                        child: DropdownButton(
                          value: _type,
                          onChanged: (String? newValue) {
                            setState(() {
                              _type = newValue!;
                            });
                          },
                          items: <String>[
                            '${AppLocalizations.of(context)!.type_asso_donation}',
                            '${AppLocalizations.of(context)!.type_asso_charity}',
                            '${AppLocalizations.of(context)!.type_asso_other}',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostMainSubtitle(
                          AppLocalizations.of(context)!.start_date),
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          dateMask: 'd MMM yyyy',
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateLabelText: 'Date',
                          timeLabelText: "Hour",
                          validator: (val) {
                            return null;
                          },
                          onSaved: (val) => _startDate = val as Timestamp,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostMainSubtitle(AppLocalizations.of(context)!.end_date),
                      Expanded(
                        child: DateTimePicker(
                          type: DateTimePickerType.dateTime,
                          dateMask: 'd MMM yyyy',
                          initialValue: _startDate.toDate().toString(),
                          firstDate: _startDate.toDate(),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateLabelText: 'Date',
                          timeLabelText: "Hour",
                          validator: (val) {
                            return null;
                          },
                          onSaved: (val) => _endDate = val as Timestamp,
                        ),
                      )
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
        ),
      ),
    );
  }
}
