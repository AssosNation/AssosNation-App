class AnUser {
  final String uid;
  final String mail;
  late final String? firstName;
  late final String? lastName;
  late final List<dynamic>? subscriptions;

  AnUser(this.uid, this.mail);
  AnUser.withData(
      this.uid, this.mail, this.firstName, this.lastName, this.subscriptions);
}
