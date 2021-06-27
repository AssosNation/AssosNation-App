import 'package:assosnation_app/components/posts/post_main_title.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssociationInformationsDialog extends StatelessWidget {
  const AssociationInformationsDialog({Key? key, required this.assos})
      : super(key: key);

  final Association assos;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PostMainTitle("Informations"),
          Row(
            children: [
              Icon(
                CupertinoIcons.location,
                color: Colors.teal,
              ),
              Text(
                assos.address,
                style: TextStyle(color: Colors.teal),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_city_rounded,
                color: Colors.teal,
              ),
              Text(
                assos.city,
                style: TextStyle(color: Colors.teal),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.phone,
                color: Colors.teal,
              ),
              Text(
                assos.phone,
                style: TextStyle(color: Colors.teal),
              )
            ],
          ),
          Row(
            children: [
              Icon(CupertinoIcons.person_alt_circle, color: Colors.teal),
              Text(
                assos.president,
                style: TextStyle(color: Colors.teal),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                icon: Icon(CupertinoIcons.clear),
                label: Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
