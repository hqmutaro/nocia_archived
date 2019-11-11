import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/user_config_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/db_reference.dart';

class FirebaseUserConfigRepository extends UserConfigRepository {
  final FirebaseUser user;

  FirebaseUserConfigRepository({@required this.user}): assert(user != null);

  Future<void> setConfig({
    @required Department department,
    Course course,
    @required int grade,
    @required Term term,
  }) async{
    await instance().child("user").child(user.uid).child("config")
        .set(<String, dynamic>{
          "department": getDepartmentId(department),
          "course": getCourseId(course) ?? null,
          "grade": grade.toString(),
          "term": getTermId(term)
    });
  }

  Future<Map<String, dynamic>> getConfigMap() async{
    var snapshot = await instance().child("user").child(user.uid).child("config").once();
    return <String, dynamic>{
      "department": getDepartment(snapshot.value["department"]),
      "course": getCourse(snapshot.value["course"]) ?? null,
      "grade": snapshot.value["grade"],
      "term": getTerm(snapshot.value["term"])
    };
  }
}