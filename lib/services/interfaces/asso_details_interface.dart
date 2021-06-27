import 'package:assosnation_app/services/models/association.dart';

abstract class AssoDetailsInterface {
  Future updateName(Association assos, String content);
  Future updatePhone(Association assos, String content);
}
