import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/pages/calendar_page.dart';
import 'package:assosnation_app/pages/discover_page.dart';
import 'package:assosnation_app/pages/messaging_page.dart';
import 'package:assosnation_app/pages/news_feed_page.dart';
import 'package:assosnation_app/pages/profile_page.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/route_generator.dart';
import 'package:assosnation_app/utils/search/AssociationSearch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appName = "AssosNation";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<AnUser?>(
              create: (context) => AuthService().user,
              initialData: null,
              builder: (context, child) => MaterialApp(
                    title: appName,
                    theme: ThemeData(
                      primarySwatch: Colors.teal,
                      textTheme: GoogleFonts.montserratTextTheme(
                        Theme.of(context).textTheme,
                      ),
                    ),
                    home: MyHomePage(key: UniqueKey(), title: appName),
                    initialRoute: "/",
                    onGenerateRoute: RouteGenerator.generateRoute,
                  ));
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 2;

  final List<Widget> _pages = [
    NewsFeed(),
    MessagingPage(),
    Discover(),
    Profile(),
    Calendar(),
  ];

  Widget _diplayBottomNavBar() {
    return BottomNavigationBar(
        currentIndex: _selectedPage,
        unselectedItemColor: Colors.teal[400],
        selectedItemColor: Colors.teal,
        selectedFontSize: 16,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed), label: "Feed"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Messaging"),
          BottomNavigationBarItem(
              icon: Icon(Icons.saved_search), label: "Discover"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Calendar")
        ],
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        });
  }

  Widget _profileImageIfConnected(AnUser? _user) {
    if (_user != null) {
      return Padding(
        padding: const EdgeInsets.all(3),
        child: CircleAvatar(
          child: Text(_user.mail.substring(0, 2).toUpperCase()),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final _user = context.watch<AnUser?>();

    return Scaffold(
      bottomNavigationBar: _user != null ? _diplayBottomNavBar() : null,
      appBar: AppBar(
        centerTitle: true,
        leading: _profileImageIfConnected(_user),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/logo_an.png",
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text(widget.title)),
          ],
        ),
        actions: [
          StreamBuilder<List<Association>>(
              stream: FireStoreService().getAllAssociations().asStream(),
              builder: (context, AsyncSnapshot<List<Association>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          final result = await showSearch(
                              context: context,
                              delegate: AssociationSearch(snapshot.data!));
                          if (result != null)
                            Navigator.of(context).pushNamed(
                                "/associationDetails",
                                arguments: result);
                        });
                  }
                }
                return Container();
              })
        ],
      ),
      body: Center(
          child: _user != null ? _pages[_selectedPage] : Authentication()),
    );
  }
}
