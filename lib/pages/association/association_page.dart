import 'package:assosnation_app/components/an_big_title.dart';
import 'package:assosnation_app/components/description_asso.dart';
import 'package:assosnation_app/components/edit_asso_dialog.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationPage extends StatelessWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                color: Colors.teal,
                child: AnBigTitle(_association!.name),
                height: 70,
              ),
              Image.network(
                _association.banner,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: DescriptionAsso(_association.description)),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.home_filled, color: Colors.teal),
                    Text(
                        "Nom de l'association : ${context.watch<Association?>()!.name}"),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.teal),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            EditAssoDialog(_association, "name"),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.phone, color: Colors.teal),
                    Text("Numéro de téléphone : ${_association.phone}"),
                    IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EditAssoDialog(_association, "phone"),
                            ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.home_filled, color: Colors.teal),
                    Text("Adresse : ${_association.address}"),
                    IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {})
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.location_city, color: Colors.teal),
                    Text("Ville : ${_association.city}"),
                    IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {})
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.mail, color: Colors.teal),
                    Text("Mail : ${_association.mail}"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.teal),
                    Text(
                        "Président de l'association : ${_association.president}"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
