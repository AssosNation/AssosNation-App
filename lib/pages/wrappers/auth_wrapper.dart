import 'package:assosnation_app/components/scaffolds/association_scaffold.dart';
import 'package:assosnation_app/components/scaffolds/user_scaffold.dart';
import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    final _association = context.watch<Association?>();

    if (_user != null)
      return UserScaffold();
    else if (_association != null)
      return AssociationScaffold();
    else
      return Authentication();
  }
}
