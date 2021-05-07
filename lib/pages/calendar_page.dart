import 'package:flutter/material.dart';

import 'detail/signin_form.dart';
import 'detail/signup_form.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Ceci est un evenement"),
                              Text("01/01/1990"),
                              GestureDetector(
                                onTap: () => {}, //Ajouter au calendrier de son app,
                                child: Text("Ajouter au calendrier"),
                              )
                            ]
                        ),
                      )
                    ]
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*


 */
