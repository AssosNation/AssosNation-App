import 'package:assosnation_app/components/an_title.dart';
import 'package:assosnation_app/components/association_card.dart';
import 'package:assosnation_app/pages/detail/location.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnTitle("DISCOVER"),
        Flexible(
          flex: 1,
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
                          return Container(
                            child: AssociationCard(assosList[index]),
                          );
                        },
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.80),
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
          flex: 2,
          child: Card(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Location(),
          ),
        )
      ],
    );
  }
}
