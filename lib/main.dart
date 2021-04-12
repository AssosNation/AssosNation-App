import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
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
  void connection() {
    final service = AuthService();
    service.signUpUserWithEmailAndPwd("tester3@test.fr", "000000");
  }

  void connection2() {
    final service = AuthService();
    service.signIn("tester3@test.fr", "000000");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Authentication()),
    );
  }
}
