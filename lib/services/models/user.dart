import 'package:assosnation_app/services/models/association.dart';

class User {
  final String firstName;
  final String lastName;
  final String mail;
  final List<Association>? subscriptions;

  User(this.firstName, this.lastName, this.mail, this.subscriptions);
}