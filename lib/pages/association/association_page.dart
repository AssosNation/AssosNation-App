import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationPage extends StatelessWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [Text(_association!.name)],
        ),
        Row(
          children: [Text(_association.name)],
        ),
        Row(
          children: [Text(_association.name)],
        ),
        Row(
          children: [Text(_association.name)],
        ),
      ],
    );
  }
}
