import 'package:flutter/material.dart';

class AssociationCardInfos extends StatelessWidget {
  final String infos;

  const AssociationCardInfos(this.infos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(infos,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.teal)),
    );
  }
}
