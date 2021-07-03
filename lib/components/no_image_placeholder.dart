import 'package:flutter/material.dart';

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Theme.of(context).accentColor, width: 2)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
