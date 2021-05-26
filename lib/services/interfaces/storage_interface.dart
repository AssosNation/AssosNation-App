abstract class StorageInterface {
  Future getBannerByAssociation();
  Future<String> getDefaultAssocaitonBannerUrl();
  Future getImageByPost();
  Future getBannerByName(String path);
  Future uploadBannerToStorage(dynamic banner);
}
