import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/lecture.dart';
import 'package:nocia/domain/repository/subject_data_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/dto/lecture_dto.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

class FirebaseTimetableRepository {
  final String uid;

  FirebaseTimetableRepository({@required this.uid}): assert(uid != null);

  Future<dynamic> lectureTimetables() async{
    var user = await UserRepository().getUser();
    var info = await FirebaseUserInfoRepository(user: user).getUserInfo();

    var dayTimetable = <List<Map<String, dynamic>>>[];
    var timetableList = info["timetable"];
    for (var list in timetableList) {
      var timetable = <Map<String, dynamic>>[];

      for (var lectureData in list) {
        var map = <String, dynamic>{
          "id": lectureData["id"],
          "name": lectureData["name"],
          "staffs": lectureData["staffs"],
          "grade": lectureData["grade"],
          "term": lectureData["term"]
        };
        timetable.add(map);
      }
      dayTimetable.add(timetable);
    }
    return dayTimetable;
  }
}