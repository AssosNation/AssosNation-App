import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
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

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        print("${_formKey.currentState}");
        _formKey.currentState!.save();
        dynamic res = await _auth.signIn(_mail, _pwd);
        print(" response => $res");
        if (res == null) {
          _displaySnackBarWithMessage("Failed to connect, try again");
        } else {
          _displaySnackBarWithMessage("Succesfully connected ! Welcome");
        }
      }
    }
  }

  _isEmailValidated(String email) {
    return email.contains(new RegExp(r'[a-z0-9A-Z-.]+1*@[a-zA-Z]+\.[a-z]+'));
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
            child: Column(
              children: [
                Text("Signing Up"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: "Enter your First Name"),
                        keyboardType: TextInputType.name,
                        validator: (firstName) {
                          if (firstName!.isEmpty || _isEmailValidated(_mail))
                            return "This field can't be empty";
                          _firstName = firstName;
                          return null;
                        },
                        onSaved: (firstName) {
                          if (firstName != null) {
                            setState(() => _firstName = firstName);
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: "Enter your First Name"),
                        keyboardType: TextInputType.name,
                        validator: (lastName) {
                          if (lastName!.isEmpty || _isEmailValidated(_mail))
                            return "This field can't be empty";
                          _lastName = lastName;
                          return null;
                        },
                        onSaved: (lastName) {
                          if (lastName != null) {
                            setState(() => _lastName = lastName);
                          }
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
                        validator: (email) {
                          if (email!.isEmpty || _isEmailValidated(_mail))
                            return "This is not a valid email address";
                          _mail = email;
                          return null;
                        },
                        onSaved: (emailValue) {
                          if (emailValue != null) {
                            setState(() => _mail = emailValue);
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: "Enter your password"),
                        obscureText: true,
                        validator: (pwd) {
                          if (pwd == null || pwd == "")
                            return "Not a valid password";
                          return null;
                        },
                        onSaved: (pwdValue) {
                          if (pwdValue != null) {
                            setState(() => _pwd = pwdValue);
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: "Confirm your password"),
                        obscureText: true,
                        validator: (pwd) {
                          if (pwd == null || pwd == "")
                            return "Not a valid password";
                          _pwd = pwd;
                          return null;
                        },
                        onSaved: (pwdValue) {
                          if (pwdValue != null) {
                            setState(() => _pwd = pwdValue);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                  child: ElevatedButton(
                    onPressed: _verifyAndValidateForm,
                    child: Text("Validate"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
