import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/firebase/firestore/messaging_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String uid;
  List messages;
  List participants;
  List<String> names = [];

  Conversation(this.uid, this.messages, this.participants) {
    this.participants.forEach((participant) async {
      names.add(await MessagingService().getParticipantName(participant));
    });
  }

  String getDiffTimeBetweenNowAndLastMessage() {
    final DateTime currentTime = Timestamp.now().toDate();
    final Duration difference =
        currentTime.difference(messages.last["timestamp"].toDate());
    if (difference.inMinutes < 60)
      return "${difference.inMinutes} min";
    else if (difference.inHours < 24)
      return "${difference.inHours}h";
    else
      return "${difference.inDays} days";
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

  DocumentReference getDocRefWithId(String id) {
    return participants.firstWhere((docRef) => docRef.id == id);
  }

  Future<String> getReceiverName(String id) async {
    DocumentReference docRef =
        participants.firstWhere((participant) => participant.id != id);
    final name = await docRef.get();
    if (name.data()!.containsKey("firstName"))
      return "${name.get("firstName")} ${name.get("lastName")}";
    else
      return name.get("name");
  }
}
