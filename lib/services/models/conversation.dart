import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String uid;
  final String title;
  List messages;
  List participants;
  Conversation(this.uid, this.title, this.messages, this.participants);

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
      final user =
          await FireStoreService().getUserInfosFromDB(_getLastMessageSender());
      return "${user.firstName} ${user.lastName}";
    } on FirebaseException catch (e) {
      Future.error("Error when retrieving user infos for last message");
    }
    return Future.error("something happenened");
  }
}
