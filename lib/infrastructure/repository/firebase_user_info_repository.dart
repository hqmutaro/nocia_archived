import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/repository/user_info_repository.dart';
import 'package:nocia/infrastructure/repository/db_reference.dart';

class FirebaseUserInfoRepository implements UserInfoRepository {
  final FirebaseUser user;

  FirebaseUserInfoRepository({@required this.user});

  Future<void> setUpUserData({String name}) async{
    await instance().child("user").child(user.uid).set(<String,dynamic>{
      "name": name,
      "timetable": null
    });
  }

  Future<bool> existsUserInfo() async{
    var userInfo = await getUserInfo();
    return userInfo != null;
  }

  Future<dynamic> getUserInfo() async{
    var data = await instance().child("user").child(user.uid).once().then((data) => data.value);
    return data;
  }
}