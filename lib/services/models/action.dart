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

 Action(this.name, this.city, this.postalCode, this.address, this.description,
 this.type, this.startDate, this.endDate, this.assosId);
 }