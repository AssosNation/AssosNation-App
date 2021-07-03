import 'package:assosnation_app/components/associations_actions/action_card.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var _isFirstPart = false;

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
                onPressed: () => setState(() => _isFirstPart = true),
                child: Text(AppLocalizations.of(context)!.my_assos_actions)),
            OutlinedButton(
                onPressed: () => setState(() => _isFirstPart = false),
                child: Text(AppLocalizations.of(context)!.all_events_label)),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: _isFirstPart
                    ? FireStoreService().getUserAssociationsByDate(_user?.uid)
                    : FireStoreService().getAllActions(_user?.uid),
                builder:
                    (context, AsyncSnapshot<List<AssociationAction>> snapshot) {
                  if (snapshot.hasData) {
                    List<AssociationAction> actionList = snapshot.data!;
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    else {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ActionCard(actionList[index], _user!.uid);
                          },
                          itemCount: actionList.length,
                          shrinkWrap: true,
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text(AppLocalizations.of(context)!.no_events_yet);
                  } else
                    return Container();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
