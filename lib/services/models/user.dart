import 'package:assosnation_app/services/models/association.dart';

class AnUser {
  final String uid;
  final String mail;
  late final String? firstName;
  late final String? lastName;
  late final List<Association>? subscriptions;

  AnUser(this.uid, this.mail);
}
