import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/material.dart';

class AssociationCard extends StatelessWidget {
  const AssociationCard(this.association);

  final Association association;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [Image.network(association.banner), Text(association.name)],
      ),
    );
  }
}
