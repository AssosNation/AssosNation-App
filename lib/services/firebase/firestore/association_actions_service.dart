import 'package:assosnation_app/services/firebase/firestore/user_service.dart';
import 'package:assosnation_app/services/interfaces/association_actions_interface.dart';
import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/services/models/association_action.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationActionsService implements AssociationActionsInterface {
  final FirebaseFirestore _service = FirebaseFirestore.instance;

  @override
  createAssociationActionForAssociation(AssociationAction action) async {
    dynamic associationInfos = {
      "address": action.address,
      "city": action.city,
      "description": action.description,
      "endDate": action.endDate,
      "startDate": action.startDate,
      "title": action.title,
      "type": action.type,
      "postalCode": action.postalCode,
      "usersRegistered": []
    };
    _service.collection('associations').doc(action.association.uid).update({
      'actions': FieldValue.arrayUnion([associationInfos])
    });
  }

  @override
  Future removeAssociationAction(AssociationAction action) async {
    action.association.actions!.removeAt(action.id);
    await _service
        .collection('associations')
        .doc(action.association.uid)
        .update({'actions': action.association.actions});
  }

  @override
  Future updateAssociationAction(
      AssociationAction oldAction, AssociationAction newAction) async {
    await this.removeAssociationAction(oldAction);
    this.createAssociationActionForAssociation(newAction);
  }

  AssociationAction? getAssociationActionFromAssociationInfos(
      Association association, int index) {
    dynamic associationInfos = association.actions![index];
    if (associationInfos == null) {
      return null;
    }

    return AssociationAction(
        index,
        associationInfos['title'],
        associationInfos['city'],
        associationInfos['postalCode'],
        associationInfos['address'],
        associationInfos['description'],
        associationInfos['type'],
        associationInfos['startDate'],
        associationInfos['endDate'],
        association,
        associationInfos['usersRegistered'].length,
        true);
  }

  Future<List<AnUser>> getParticipants(AssociationAction action) async {
    final userIdList =
        action.association.actions![action.id]['usersRegistered'];

    List<AnUser> userList = List.empty(growable: true);

    for (final userId in userIdList) {
      AnUser user = await UserService().getUserInfosFromDB(userId);
      userList.add(user);
    }

    return userList;
  }
}
