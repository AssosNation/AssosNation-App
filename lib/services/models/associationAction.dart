import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationAction {
  final String id;
  final String title;
  final String city;
  final String postalCode;
  final String address;
  final String description;
  final String type;
  final Timestamp startDate;
  final Timestamp endDate;
  final Association association;

  AssociationAction(
      this.id,
      this.title,
      this.city,
      this.postalCode,
      this.address,
      this.description,
      this.type,
      this.startDate,
      this.endDate,
      this.association);
}
