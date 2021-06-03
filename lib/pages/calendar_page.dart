import 'package:assosnation_app/components/event_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/action.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                  future: FireStoreService().getAllUserRegisteredActions(),
                  builder: (context,
                      AsyncSnapshot<List<AssociationAction>> snapshot) {
                    if (snapshot.hasData) {
                      List<AssociationAction> actionList = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return AssociationActionCard(actionList[index]);
                          },
                          itemCount: actionList.length,
                          shrinkWrap: true,
                        ),
                      );
                    } else {
                      return Text("Pas d'actions pour toi l'ami");
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
