import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationApplyForm extends StatefulWidget {
  @override
  _AssociationApplyFormState createState() => _AssociationApplyFormState();
}

class _AssociationApplyFormState extends State<AssociationApplyForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String _name = "";
  String _president = "";
  String _description = "";
  String _mail = "";
  String _phone = "";
  String _address = "";
  String _postalCode = "";
  String _city = "";
  String _pwd = "";
  String _pwd2 = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res = await _auth.applyAsAssociation(_name, _description,
            _president, _mail, _phone, _address, _postalCode, _city, _pwd);
        if (res == null) {
          _displaySnackBarWithMessage("Failed to connect, try again");
        } else {
          _displaySnackBarWithMessage("Succesfully connected ! Welcome");
        }
      }
    }
  }

  _isEmailValidated(String email) {
    return email
        .contains(new RegExp(r'([a-z0-9A-Z-.]+@[a-zA-Z]+\.[a-z]{1,3})'));
  }

  _displaySnackBarWithMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Association Application"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: Column(
                      children: [
                        Text("General Informations"),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter the association's Name"),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (name) {
                            if (name!.isNotEmpty) {
                              _name = name;
                              return null;
                            } else
                              return "Please enter the association's name";
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter the president's name"),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (president) {
                            if (president!.isNotEmpty) {
                              _president = president;
                              return null;
                            } else
                              return "Please enter the president's name";
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter the association's description"),
                          keyboardType: TextInputType.multiline,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (description) {
                            if (description!.isNotEmpty) {
                              _description = description;
                              return null;
                            } else
                              return "Please enter the association's description";
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: Column(
                      children: [
                        Text("Contact Informations"),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText:
                                    "Enter the association email address"),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) {
                              if (_isEmailValidated(email!)) {
                                _mail = email;
                                return null;
                              } else if (email.isEmpty)
                                return "This field cannot be empty";
                              else
                                return "This email address is not valid";
                            }),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText:
                                    "Enter the association phone number"),
                            keyboardType: TextInputType.phone,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (phone) {
                              if (phone!.isNotEmpty) {
                                _phone = phone;
                                return null;
                              } else
                                return "Please enter the association's description";
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: Column(
                      children: [
                        Text("Postal Informations"),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter the association's address"),
                          keyboardType: TextInputType.streetAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (address) {
                            if (address!.isNotEmpty) {
                              _address = address;
                              return null;
                            } else
                              return "Please enter the address";
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Enter the city"),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (city) {
                            if (city!.isNotEmpty) {
                              _city = city;
                              return null;
                            } else
                              return "Please enter the city";
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter the association's postal code"),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (postalCode) {
                            if (postalCode!.isNotEmpty) {
                              _postalCode = postalCode;
                              return null;
                            } else
                              return "Please enter the postal code";
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: "Enter your password"),
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pwd) {
                            if (pwd!.isNotEmpty) {
                              _pwd = pwd;
                              return null;
                            } else
                              return "Please enter a password";
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Confirm your password"),
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pwd2) {
                            if (pwd2!.isNotEmpty && pwd2 == _pwd) {
                              _pwd2 = pwd2;
                              return null;
                            } else
                              return "Please match your passwords";
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: ElevatedButton(
                      onPressed: _verifyAndValidateForm,
                      child: Text("Send your application"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
