import 'package:assosnation_app/services/models/post.dart';
import 'package:assosnation_app/services/models/action.dart';

class Association {
  final String name;
  final String description;
  final String mail;
  final String address;
  final String city;
  final String postalCode;
  final String banner;
  final String phone;
  final String president;
  final String type;

  final List<Post>? posts;
  final List<Action>? actions;

  Association({ required this.name, required this.description, required this.mail,
    required this.address, required this.city, required this.postalCode,
    required this.phone, required this.banner, required this.president,
    required this.type, this.posts, this.actions});

}