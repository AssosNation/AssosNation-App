import 'dart:io';

import 'package:assosnation_app/services/interfaces/storage_interface.dart';
import 'package:assosnation_app/services/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  Future<String> getImageByPost(String _postId) async {
    try {
      Reference ref = _storage
          .ref()
          .child('posts_images')
          .child('5abb9eb43216742a008b45cc-1334-667.jpg');
      final _imageUrl = await ref.getDownloadURL();
      return _imageUrl;
    } on FirebaseException catch (e) {
      return Future.error("Cannot find the default image url");
    }
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

  Future<PermissionStatus> _requesPhotoAccessPermission() async {
    await Permission.photos.request();
    return await Permission.photos.status;
  }

  @override
  Future<String> uploadImageAndReturnImgPath(AnUser userId) async {
    final permissionStatus = await _requesPhotoAccessPermission();

    if (permissionStatus.isGranted) {
      final _picker = ImagePicker();
      PickedFile? image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        final snapshot =
            await _storage.ref().child('users_images/$userId').putFile(file);

        return await snapshot.ref.getDownloadURL();
      } else {
        return Future.error('No Path Received');
      }
    } else {
      return Future.error('Grant Permissions and try again');
    }
  }
}
