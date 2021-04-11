import 'package:assosnation_app/services/models/association.dart';

class User {
  final String firstName;
  final String lastName;
  final String mail;
  final List<Association>? subscriptions;

  User({required this.firstName, required this.lastName, required this.mail, this.subscriptions});
}