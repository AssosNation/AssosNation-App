import 'dart:io';

import 'package:assosnation_app/services/models/user.dart';

abstract class StorageInterface {
  Future<String> getBannerByAssociation(String assosId);

  Future<String> getDefaultAssocaitonBannerUrl();

  Future<String> getImageByPost(String _postId);

  Future uploadAndUpdateUserImage(AnUser user);

  Future<String> getDefaultUserProfileImg();

  Future<File> selectImageFromGallery();

  Future<String> uploadPostImageToStorage(File image, String postId);

  Future<String> uploadAssociationImageToStorage(File image, String assosId);
}
