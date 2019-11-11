abstract class UserInfoRepository {
  Future<void> setUpUserData({String name});

  Future<bool> existsUserInfo();

  Future<dynamic> getUserInfo();
}