class Association {
  final String uid;
  final String name;
  final String description;
  final String mail;
  final String address;
  final String city;
  final String postalCode;
  final String banner;
  final String phone;
  final String president;
  final bool approved;
  final String? type;
  final List<dynamic>? posts;
  final List<dynamic>? actions;
  List<dynamic> subscribers;

  Association(
      this.uid,
      this.name,
      this.description,
      this.mail,
      this.address,
      this.city,
      this.postalCode,
      this.phone,
      this.banner,
      this.president,
      this.approved,
      this.type,
      this.posts,
      this.actions,
      this.subscribers);

  Association.application(
      this.uid,
      this.name,
      this.description,
      this.mail,
      this.address,
      this.city,
      this.postalCode,
      this.phone,
      this.banner,
      this.president,
      this.approved,
      this.type,
      this.posts,
      this.actions,
      this.subscribers);
}
