import 'package:assosnation_app/intro.dart';
import 'package:assosnation_app/pages/authentication.dart';
import 'package:assosnation_app/pages/detail/association_action_participants.dart';
import 'package:assosnation_app/pages/detail/association_apply_form.dart';
import 'package:assosnation_app/pages/detail/association_calendar.dart';
import 'package:assosnation_app/pages/detail/association_conversation_page.dart';
import 'package:assosnation_app/pages/detail/association_details.dart';
import 'package:assosnation_app/pages/detail/user_conversation_page.dart';
import 'package:assosnation_app/pages/user/messaging_page.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
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
      case "/convAsUser":
        if (args is Conversation) {
          return MaterialPageRoute(
              builder: (_) => UserConvPage(
                    conversation: args,
                  ));
        }
        return _errorRoute();
      case "/convAsAssociation":
        if (args is Conversation) {
          return MaterialPageRoute(
              builder: (_) => AssociationConvPage(
                    conversation: args,
                  ));
        }
        return _errorRoute();
      case "/associationDetails":
        if (args is Association) {
          return MaterialPageRoute(
              builder: (context) => AssociationDetails(args));
        }
        return _errorRoute();

      case "/messagingPage":
        return MaterialPageRoute(builder: (_) => MessagingPage());

      case "/intro":
        return MaterialPageRoute(builder: (_) => IntroScreen());

      case "/associationCalendarPage":
        if (args is Association) {
          return MaterialPageRoute(
              builder: (context) => AssociationCalendar(args));
        }
        return _errorRoute();

      case "/associationActionParticipants":
        if (args is AssociationAction) {
          return MaterialPageRoute(
              builder: (context) => AssociationActionParticipants(args));
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
