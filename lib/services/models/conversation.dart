import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/message.dart';

class Conversation {
  final String uid;
  final String title;
  List messages;
  List participants;

  Conversation(this.uid, this.title, this.messages, this.participants) {
    _retrieveAllMessagesFromDb();
  }

  FireStoreService _service = FireStoreService();

  _retrieveAllMessagesFromDb() async {
    List<Message> _messages = await _service.getAllMessagesByConversation(this);
    messages = _messages;
    print(_messages);
  }
}
