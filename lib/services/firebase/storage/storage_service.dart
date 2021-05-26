import 'package:assosnation_app/services/interfaces/storage_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService extends StorageInterface {
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future getBannerByAssociation() {
    // TODO: implement getBannerByAssociation
    throw UnimplementedError();
  }

  @override
  Future<String> getDefaultAssocaitonBannerUrl() async {
    try {
      Reference ref = _storage
          .ref()
          .child('associations_banners')
          .child('default_assos.jpg');
      final _imageUrl = await ref.getDownloadURL();
      return _imageUrl;
    } on FirebaseException catch (e) {
      return Future.error("Cannot find the default image url");
    }
  }

  @override
  Future getImageByPost() {
    // TODO: implement getImageByPost
    throw UnimplementedError();
  }

  @override
  Future getBannerByName(String path) {
    // TODO: implement getBannerByName
    throw UnimplementedError();
  }

  @override
  Future uploadBannerToStorage(banner) {
    // TODO: implement uploadBannerToStorage
    throw UnimplementedError();
  }
}
