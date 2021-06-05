import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/messaging/messaging_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String uid;
  final String title;
  List messages;
  List participants;
  List<String> names = [];

  Conversation(this.uid, this.title, this.messages, this.participants) {
    this.participants.forEach((participant) async {
      names.add(await MessagingService().getParticipantName(participant));
    });
  }

  getDiffTimeBetweenNowAndLastMessage() {
    final DateTime currentTime = Timestamp.now().toDate();
    final Duration difference =
        currentTime.difference(messages.last["timestamp"].toDate());
    return difference.inHours;
  }

  String getLastMessageSent() {
    return messages.last["content"].toString();
  }

  String _getLastMessageSender() {
    return messages.last["sender"].id;
  }

  Future<String> getLastMessageSenderAsync() async {
    try {
      if (messages.last["sender"].toString().contains("users")) {
        final lastSender = await FireStoreService()
            .getUserInfosFromDB(_getLastMessageSender());
        return "${lastSender.firstName} ${lastSender.lastName}";
      } else {
        final lastSender = await FireStoreService()
            .getAssociationInfosFromDB(_getLastMessageSender());
        return "${lastSender.name}";
      }
    } on FirebaseException catch (e) {
      Future.error("Error when retrieving user infos for last message");
    }
    return Future.error("something happenened");
  }
}
