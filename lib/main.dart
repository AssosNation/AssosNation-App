import 'package:assosnation_app/components/scaffolds/association_scaffold.dart';
import 'package:assosnation_app/components/scaffolds/user_scaffold.dart';
import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:assosnation_app/utils/association_search.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:assosnation_app/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              StreamProvider<AnUser?>(
                create: (context) => AuthService().user,
                initialData: null,
              ),
              StreamProvider<Association?>(
                create: (context) => AuthService().association,
                initialData: null,
              ),
            ],
            builder: (context, child) => MaterialApp(
              title: Constants.appName,
              theme: ThemeData(
                primarySwatch: Colors.teal,
                appBarTheme: AppBarTheme(color: Colors.teal[300]),
                cardTheme: CardTheme(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.elliptical(15, 10),
                            right: Radius.elliptical(10, 15)))),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.teal[300],
                  unselectedItemColor: Colors.teal[100],
                  selectedItemColor: Colors.white,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  type: BottomNavigationBarType.fixed,
                ),
                textTheme: GoogleFonts.montserratTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: L10n.all,
              home: MyHomePage(
                key: UniqueKey(),
              ),
              initialRoute: "/",
              onGenerateRoute: RouteGenerator.generateRoute,
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
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _selectScaffold(_user, _association) {
    if (_user != null)
      return UserScaffold();
    else if (_association != null)
      return AssociationScaffold();
    else
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/logo_an.png",
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Constants.appName)),
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
        body: Center(child: Authentication()),
      );
  }

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();
    final _user = context.watch<AnUser?>();

    return _selectScaffold(_user, _association);
  }
}
