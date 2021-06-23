import 'package:assosnation_app/components/association_action_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/associationAction.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var _isFirstPart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => setState(() => _isFirstPart = true),
                  child: Text("Actions de mes assos")),
              ElevatedButton(
                  onPressed: () => setState(() => _isFirstPart = false),
                  child: Text("Toutes les actions")),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                  future: _isFirstPart
                      ? FireStoreService().getUserAssociationsByDate()
                      : FireStoreService().getAllActions(),
                  builder: (context,
                      AsyncSnapshot<List<AssociationAction>> snapshot) {
                    if (snapshot.hasData) {
                      List<AssociationAction> actionList = snapshot.data!;
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return CircularProgressIndicator();
                      else {
                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return AssociationActionCard(actionList[index]);
                            },
                            itemCount: actionList.length,
                            shrinkWrap: true,
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text("Pas d'actions pour toi l'ami");
                    } else
                      return Container();
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
