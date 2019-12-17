abstract class UserInfoRepository {
  Future<void> setUpUserData({String name});

  Future<bool> existsUserInfo();

  void updateUserData({String key, dynamic value});

  Future<dynamic> getUserInfo();
}