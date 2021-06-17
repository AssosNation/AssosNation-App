import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/association_card.dart';
import 'package:assosnation_app/pages/detail/location.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  TextEditingController _textEditingController = TextEditingController();

  _search() {
    _textEditingController.addListener(() {
      print(_textEditingController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnTitle("Discover an association"),
            Flexible(
              flex: 3,
              child: FutureBuilder(
                  future: FireStoreService().getAllAssociations(),
                  builder: (ctx, AsyncSnapshot<List<Association>> snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        case ConnectionState.done:
                          List<Association> assosList = snapshot.data!;
                          return CarouselSlider.builder(
                            itemCount: assosList.length,
                            itemBuilder: (ctx, index, realIdx) {
                              return AssociationCard(assosList[index]);
                            },
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayAnimationDuration: Duration(seconds: 2),
                                autoPlayCurve: Curves.easeInOutBack,
                                height:
                                    MediaQuery.of(context).size.height * 0.95),
                          );
                        case ConnectionState.none:
                          return CircularProgressIndicator();
                        case ConnectionState.active:
                          return CircularProgressIndicator();
                      }
                    }
                    return Container();
                  }),
            ),
            AnTitle("AROUND YOU"),
            Flexible(
              flex: 5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.elliptical(15, 10),
                        right: Radius.elliptical(10, 15))),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Location(),
              ),
            )
          ],
        ),
        FloatingSearchBar(
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.place),
                  onPressed: () {},
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) => Text("$index"),
                  ),
                ),
              );
            })
      ],
    );
  }
}
