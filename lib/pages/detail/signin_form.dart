import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _mail = "";
  String _pwd = "";

  _verifyAndValidateForm() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        dynamic res = await _auth.signIn(_mail, _pwd);
        if (res == null) {
          _displaySnackBarWithMessage(
              "Failed to connect, try again", Colors.red);
        } else {
          _displaySnackBarWithMessage(
              "Succesfully connected ! Welcome", Colors.green);
        }
      }
    }
  }

  _isEmailValidated(String email) {
    return email
        .contains(new RegExp(r'([a-z0-9A-Z-.]+@[a-zA-Z]+\.[a-z]{1,3})'));
  }

  _displaySnackBarWithMessage(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
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
                Text("Login"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                  child: Column(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: "Enter your email address"),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                  child: ElevatedButton(
                    onPressed: _verifyAndValidateForm,
                    child: Text("Connect"),
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
