import 'dart:math';

import 'package:assosnation_app/services/models/association.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssociationSearch extends SearchDelegate {
  final List<Association> associations;
  final _textColor = Colors.teal;

  @override
  String? get searchFieldLabel => "Search an association";
  @override
  TextStyle? get searchFieldStyle =>
      TextStyle(fontStyle: FontStyle.italic, fontSize: 16);

  AssociationSearch(this.associations) {
    associations.shuffle(Random(Timestamp.now().microsecondsSinceEpoch));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    var results = associations
        .where((a) => a.name.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      children: results
          .map<ListTile>((a) => ListTile(
                title: Text(a.name, style: TextStyle(color: _textColor)),
                leading: Icon(Icons.subdirectory_arrow_right_sharp),
                onTap: () {
                  close(context, a);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    late final Iterable<Association> associationReduced;
    if (associations.length < 3)
      associationReduced = associations.getRange(0, 4);
    else
      associationReduced = associations;

    final List<Widget> assosAsWidgetList = associationReduced
        .map((a) => ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text(a.name),
              onTap: () => close(context, a),
            ))
        .toList();

    return ListView(children: assosAsWidgetList);
  }
}
