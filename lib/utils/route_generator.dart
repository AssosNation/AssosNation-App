import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/pages/detail/association_apply_form.dart';
import 'package:assosnation_app/pages/detail/conversation_page.dart';
import 'package:assosnation_app/services/models/conversation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Authentication());
      case "/applyAssociation":
        return MaterialPageRoute(builder: (_) => AssociationApplyForm());
      case "/conversation":
        print("args => $args");
        if (args is Conversation) {
          return MaterialPageRoute(
              builder: (context) => ConversationPage(
                    conversation: args,
                  ));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
