import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/material.dart';

class AssociationSearch extends SearchDelegate {
  final List<Association> associations;

  AssociationSearch(this.associations);

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
                title: Text(a.name),
                leading: Icon(Icons.book),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/associationDetail', arguments: a);
                  close(context, a);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = associations
        .where((a) => a.name.toUpperCase().contains(query.toLowerCase()));
    return ListView(
        children: results
            .map((a) => ListTile(
                  title: Text(a.name),
                  onTap: () => close(context, a),
                ))
            .toList());
  }
}
