import 'package:assosnation_app/services/models/association.dart';

class AnUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String mail;
  final List<Association>? subscriptions;

  AnUser(this.uid, this.firstName, this.lastName, this.mail, this.subscriptions);
}