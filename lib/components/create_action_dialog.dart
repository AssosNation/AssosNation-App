import 'package:assosnation_app/components/posts/post_main_subtitle.dart';
import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/firebase/firestore/association_actions_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateActionDialog extends StatefulWidget {
  final association;
  CreateActionDialog(this.association);

  @override
  _CreateActionDialogState createState() => _CreateActionDialogState();
}

class _CreateActionDialogState extends State<CreateActionDialog> {
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
        AssociationAction action = AssociationAction(
            this.widget.association.actions.length,
            _title,
            _city,
            _postalCode,
            _address,
            _description,
            _type,
            _startDate,
            _endDate,
            this.widget.association,
            0,
            false);
        AssociationActionsService()
            .createAssociationActionForAssociation(action);
        Navigator.pop(context);
        _displaySnackBarWithMessage("Your post has been created", Colors.green);
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
                  PostMainTitle("Editing post"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PostMainSubtitle("Title : "),
                      Expanded(
                        child: TextFormField(
                          maxLength: 30,
                          initialValue: _title,
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
                      PostMainSubtitle("city : "),
                      Expanded(
                        child: TextFormField(
                          maxLength: 30,
                          autocorrect: true,
                          initialValue: _city,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (city) {
                            if (city!.isNotEmpty) {
                              _city = city;
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
                      PostMainSubtitle("Postal code : "),
                      Expanded(
                        child: TextFormField(
                          maxLength: 5,
                          autocorrect: true,
                          initialValue: _postalCode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (postalCode) {
                            if (postalCode!.isNotEmpty) {
                              _postalCode = postalCode;
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
                      PostMainSubtitle("Address : "),
                      Expanded(
                        child: TextFormField(
                          maxLength: 50,
                          autocorrect: true,
                          initialValue: _address,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (address) {
                            if (address!.isNotEmpty) {
                              _address = address;
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
                      PostMainSubtitle("Description : "),
                      Expanded(
                        child: TextFormField(
                          maxLength: 150,
                          autocorrect: true,
                          initialValue: _description,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (description) {
                            if (description!.isNotEmpty) {
                              _description = description;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PostMainSubtitle("Type : "),
                      Expanded(
                        child: DropdownButton(
                          value: _type,
                          onChanged: (String? newValue) {
                            setState(() {
                              _type = newValue!;
                            });
                          },
                          items: <String>[
                            'Donation',
                            'Action caritative',
                            'Autre',
                            'type'
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
                      PostMainSubtitle("Start date : "),
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
                      PostMainSubtitle("End date : "),
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
      ),
    );
  }
}
