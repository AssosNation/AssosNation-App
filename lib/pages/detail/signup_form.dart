import 'package:assosnation_app/components/forms/form_main_title.dart';
import 'package:assosnation_app/components/forms/form_subtitle.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/utils.dart';
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
          Utils.displaySnackBarWithMessage(
              context, "Failed to connect, try again", Colors.green);
        } else {
          Utils.displaySnackBarWithMessage(
              context, "Succesfully connected ! Welcome", Colors.deepOrange);
        }
      }
    }
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormMainTitle(AppLocalizations.of(context)!.signup_label),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                      child: Column(
                        children: [
                          FormSubTitle(
                              AppLocalizations.of(context)!.global_infos_label),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Enter your First Name"),
                            keyboardType: TextInputType.name,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                          FormSubTitle(AppLocalizations.of(context)!
                              .connection_infos_label),
                          TextFormField(
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .email_input_placeholder),
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) {
                                if (Utils.isEmailValidated(email!)) {
                                  _mail = email;
                                  return null;
                                } else if (email.isEmpty)
                                  return AppLocalizations.of(context)!
                                      .error_empty_field;
                                else
                                  return AppLocalizations.of(context)!
                                      .mail_not_valid;
                              }),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .pwd_input_placeholder),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (pwd) {
                              if (pwd!.isNotEmpty) {
                                _pwd = pwd;
                                return null;
                              } else
                                return AppLocalizations.of(context)!
                                    .enter_password;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!
                                    .pwd_input_confirm_placeholder),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (pwd2) {
                              if (pwd2!.isNotEmpty && pwd2 == _pwd) {
                                _pwd2 = pwd2;
                                return null;
                              } else
                                return AppLocalizations.of(context)!
                                    .passwords_not_matched;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                      child: ElevatedButton(
                        onPressed: _verifyAndValidateForm,
                        child: Text(AppLocalizations.of(context)!.submit_label),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 10, 0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed("/applyAssociation"),
                        child: Text(AppLocalizations.of(context)!
                            .association_apply_button),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
