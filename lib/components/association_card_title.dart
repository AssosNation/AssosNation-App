import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/material.dart';

class AssociationCardTitle extends StatelessWidget {
  final Association assos;

  const AssociationCardTitle(this.assos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(assos.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.teal)),
    );
  }
}
