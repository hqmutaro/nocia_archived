import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/user_config_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/firestore_reference.dart';

class FirebaseUserConfigRepository extends UserConfigRepository {
  final FirebaseUser user;

  FirebaseUserConfigRepository({@required this.user}): assert(user != null);

  Future<void> setConfig({
    @required Department department,
    Course course,
    @required int grade,
    @required Term term,
  }) async{
    instance().collection("user")
        .document(user.uid)
        .setData(<String, dynamic>{
          "department": getDepartmentId(department),
          "course": getCourseId(course) ?? null,
          "grade": grade.toString(),
          "term": getTermId(term)
        });
  }

  Future<void> updateConfig(String key, dynamic value) {
    instance().collection("user")
        .document(user.uid).collection("config")
        .document("1").updateData({});
  }

  Future<Map<String, dynamic>> getConfigMap() async{
    // var snapshot = await instance().child("user").child(user.uid).child("config").once();
    var snapshot = await instance().collection("user")
        .document(user.uid).collection("config")
        .document("1").get();
    return <String, dynamic>{
      "department": getDepartment(snapshot.data["department"]),
      "course": getCourse(snapshot.data["course"]) ?? null,
      "grade": snapshot.data["grade"],
      "term": getTerm(snapshot.data["term"])
    };
  }
}