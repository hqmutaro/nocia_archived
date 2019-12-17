import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/repository/user_info_repository.dart';
import 'package:nocia/infrastructure/repository/firestore_reference.dart';

class FirebaseUserInfoRepository implements UserInfoRepository {
  final FirebaseUser user;

  FirebaseUserInfoRepository({@required this.user});

  Future<void> setUpUserData({String name}) async{
    await instance().collection("user")
        .document(user.uid).setData(<String,dynamic>{
          "name": name,
          "department": null,
          "course": null,
          "grade": null,
          "term": null
    });
  }

  void updateUserData({String key, dynamic value}) => instance().collection("user")
      .document(user.uid).updateData({key: value});

  Future<bool> existsUserInfo() async{
    var userInfo = await getUserInfo();
    return userInfo != null;
  }

  Future<dynamic> getUserInfo() async{
    // var data = await instance().child("user").child(user.uid).once().then((data) => data.value);
    var data = await instance().collection("user")
        .document(user.uid).get()
        .then((value) => value.data);
    return data;
  }
}