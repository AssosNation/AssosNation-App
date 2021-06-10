import 'package:assosnation_app/components/association_card_title.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationCard extends StatelessWidget {
  const AssociationCard(this.association);

  final Association association;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.elliptical(2, 1), right: Radius.elliptical(1, 2))
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5,10, 5, 10),
        child: Center(
          child: Stack(
            children: [
              Image.network(
                association.banner,
                height: double.infinity,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null) return child;
                  else return Center(child: CircularProgressIndicator());
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AssociationCardTitle(association),
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
        ),
      ),
    );
  }
}
