import 'package:assosnation_app/components/posts/create_post_dialog.dart';
import 'package:assosnation_app/pages/association/action_management.dart';
import 'package:assosnation_app/pages/association/association_messaging_page.dart';
import 'package:assosnation_app/pages/association/association_page.dart';
import 'package:assosnation_app/pages/association/post_management.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:provider/provider.dart';

class AssociationScaffold extends StatefulWidget {
  const AssociationScaffold({Key? key}) : super(key: key);

  @override
  _AssociationScaffoldState createState() => _AssociationScaffoldState();
}

class _AssociationScaffoldState extends State<AssociationScaffold> {
  int _selectedPage = 2;

  final List<Widget> _pages = [
    PostManagement(),
    ActionManagement(),
    AssociationPage(),
    AssociationMessagingPage(),
  ];

  Widget _associationNavBar() {
    return BottomNavigationBar(
        currentIndex: _selectedPage,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: AppLocalizations.of(context)!.association_tab_posts),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_sharp),
              label: AppLocalizations.of(context)!.association_tab_events),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.association_tab_home),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: AppLocalizations.of(context)!.association_tab_messaging),
        ],
        onTap: (index) {
          setState(() {
            _selectedPage = index;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final _association = context.watch<Association?>();

    return Scaffold(
      bottomNavigationBar: _association != null ? _associationNavBar() : null,
      floatingActionButton: _selectedPage == 0
          ? FloatingActionButton(
              elevation: 2,
              child: Icon(Icons.add),
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CreatePostDialog(),
                  ))
          : Container(),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          Constants.fullHorizontalLogoPath,
          fit: BoxFit.cover,
          scale: Constants.appBarLogoScale,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                AuthService().signOff();
              })
        ],
      ),
      body: Center(child: _pages[_selectedPage]),
    );
  }
}
/*
Row(
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
        )
 */
