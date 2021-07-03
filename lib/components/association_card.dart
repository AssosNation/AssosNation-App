import 'package:assosnation_app/components/association_card_infos.dart';
import 'package:assosnation_app/components/association_card_title.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AssociationCard extends StatelessWidget {
  const AssociationCard(this.association);

  final Association association;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.teal,
      onTap: () {
        Navigator.of(context)
            .pushNamed("/associationDetails", arguments: association);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.elliptical(15, 10),
                right: Radius.elliptical(10, 15))),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                association.banner,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null)
                    return child;
                  else
                    return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.blueGrey[100],
                      borderRadius:
                          BorderRadius.vertical(top: Radius.elliptical(10, 15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AssociationCardTitle(association.name),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(10, 15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          child: AssociationCardInfos(association.city),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
                          child: AssociationCardInfos(association.postalCode),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
