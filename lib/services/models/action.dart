 import 'package:cloud_firestore/cloud_firestore.dart';

class Action {
 final String name;
 final String city;
 final String postalCode;
 final String address;
 final String description;
 final String type;

 final Timestamp startDate;
 final Timestamp endDate;

 final DocumentReference assosId;

 Action({ required this.name, required this.city, required this.postalCode,
  required this.address, required this.description,
  required this.type, required this.startDate, required this.endDate,
  required this.assosId});
 }