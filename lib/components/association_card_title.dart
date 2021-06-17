import 'package:flutter/material.dart';

class AssociationCardTitle extends StatelessWidget {
  final String assosName;

  const AssociationCardTitle(this.assosName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(assosName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.teal)),
    );
  }
}
