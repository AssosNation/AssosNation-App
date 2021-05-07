import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String _firstName = "";
  String _lastName = "";
  String _mail = "";
  String _pwd = "";
  String _pwd2 = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res = await _auth.signUpUserWithAllInfos(
            _mail, _pwd, _firstName, _lastName);
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
    return SingleChildScrollView(
      child: Container(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Signing Up"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter your First Name"),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (firstName) {
                            if (firstName!.isNotEmpty) {
                              _firstName = firstName;
                              return null;
                            } else
                              return "Please enter your first name";
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter your Last Name"),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (lastName) {
                            if (lastName!.isNotEmpty) {
                              _lastName = lastName;
                              return null;
                            } else
                              return "Please enter your first name";
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
                            decoration: InputDecoration(
                                labelText: "Enter your email address"),
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
                      child: Text("Submit"),
                    ),
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
