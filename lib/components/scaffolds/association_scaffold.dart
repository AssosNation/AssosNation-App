import 'package:assosnation_app/components/posts/create_post_dialog.dart';
import 'package:assosnation_app/pages/association/action_management.dart';
import 'package:assosnation_app/pages/association/association_messaging_page.dart';
import 'package:assosnation_app/pages/association/association_page.dart';
import 'package:assosnation_app/pages/association/post_management.dart';
import 'package:assosnation_app/services/firebase/authentication/auth_service.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssociationScaffold extends StatefulWidget {
  const AssociationScaffold({Key? key}) : super(key: key);

  @override
  _AssociationScaffoldState createState() => _AssociationScaffoldState();
}

class _AssociationScaffoldState extends State<AssociationScaffold> {
  int _selectedPage = 3;

  final List<Widget> _pages = [
    PostManagement(),
    ActionManagement(),
    AssociationPage(),
    AssociationMessagingPage(),
  ];

  Widget _associationNavBar() {
    return BottomNavigationBar(
        currentIndex: _selectedPage,
        unselectedItemColor: Colors.teal[400],
        selectedItemColor: Colors.teal,
        selectedFontSize: 16,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Posts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_sharp), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HomePage"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Messaging"),
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
        title: Text(Constants.appName),
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
