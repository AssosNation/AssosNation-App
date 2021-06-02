abstract class StorageInterface {
  Future getBannerByAssociation();
  Future<String> getDefaultAssocaitonBannerUrl();
  Future<String> getImageByPost(String _postId);
  Future getBannerByName(String path);
  Future uploadBannerToStorage(dynamic banner);
}
