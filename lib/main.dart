import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/pages/discover_page.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appName = "AssosNation";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: appName,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: StreamProvider<AnUser?>(
              create: (_) => AuthService().user,
              initialData: null,
              child: MyHomePage(key: UniqueKey(), title: appName),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return CircularProgressIndicator();
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          _user != null
              ? ElevatedButton(
                  onPressed: () {
                    final _auth = FirebaseAuth.instance;
                    _auth.signOut();
                  },
                  child: Text("Sign Out"))
              : Container()
        ],
      ),
      body: Center(child: _user == null ? Authentication() : Discover()),
    );
  }
}
