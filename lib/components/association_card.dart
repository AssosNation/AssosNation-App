import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationCard extends StatelessWidget {
  const AssociationCard(this.association);

  final Association association;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Image.network(
            association.banner,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(association.name),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Text(association.city),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                    child: Text(association.postalCode),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
