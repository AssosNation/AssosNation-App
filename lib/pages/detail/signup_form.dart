import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.50,
        child: Column(
          children: [Text("toototototo")],
        ),
      ),
    );
  }
}
