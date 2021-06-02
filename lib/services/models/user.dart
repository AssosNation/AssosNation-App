import 'package:assosnation_app/services/firebase/firestore/firestore_service.dart';
import 'package:assosnation_app/services/models/association.dart';

class AnUser {
  final String uid;
  final String mail;
  late final String? firstName;
  late final String? lastName;
  late final List<Association>? subscriptions;

  AnUser(this.uid, this.mail);
  AnUser.withData(this.uid, this.mail, this.firstName, this.lastName);
  AnUser.retrieveDataFromDb(this.uid, this.mail) {
    _retrieveUserData();
  }

  _retrieveUserData() async {
    final _userInfos = await FireStoreService().getUserInfosFromDB(this.uid);
    firstName = _userInfos.firstName;
    lastName = _userInfos.lastName;
    subscriptions = _userInfos.subscriptions;
  }
}
