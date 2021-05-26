import 'package:assosnation_app/services/models/association.dart';

abstract class StorageInterface {
  Future getBannerByAssociation();
  Future getDefaultAssocaitonBanner();
  Future getImageByPost();
}
