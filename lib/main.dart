import 'package:assosnation_app/pages/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appName = "AssosNation";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: UniqueKey(), title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton(
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut();
              },
              child: Text("Disconnect"))
        ],
      ),
      body: Center(child: Authentication()),
    );
  }
}
