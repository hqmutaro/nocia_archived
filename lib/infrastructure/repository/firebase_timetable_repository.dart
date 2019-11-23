import 'package:flutter/material.dart';
import 'package:nocia/domain/lecture.dart';
import 'package:nocia/domain/repository/timetable_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/db_reference.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

class FirebaseTimetableRepository extends TimetableRepository{
  final String uid;

  FirebaseTimetableRepository({@required this.uid}): assert(uid != null);

  Future<dynamic> createTimetable() async{
    var timetables = <List<Map<String, dynamic>>>[];
    var timeColumn;
    var range = List<int>.generate(5, (i) => i + 1);
    range.forEach((time) {
      timeColumn = <Map<String, dynamic>>[];
      range.forEach((day) {
        timeColumn.add(<String, dynamic>{
          "cell": day + ((time - 1) * 5),
          "grade": null,
          "id": null,
          "name": null,
          "staffs": [],
          "term": null
        });
      });
      timetables.add(timeColumn);
    });
    print(timetables);
    await instance().child("user").child(uid).child("timetable").set(timetables);
    return timetables;
  }

  Future<dynamic> lectureTimetables() async{
    var user = await UserRepository().getUser();
    var info = await FirebaseUserInfoRepository(user: user).getUserInfo();

    var dayTimetable = <List<Map<String, dynamic>>>[];
    var timetableList = info["timetable"];
    if (timetableList == null) {
      timetableList = await createTimetable(); // Initialize Timetable
    }
    for (var list in timetableList) {
      var timetable = <Map<String, dynamic>>[];

      for (var lectureData in list) {
        // インスタンスが肥大化するのでモデル化は非推奨
        // モデル化は単講義のセット時に
        var map = <String, dynamic>{
          "cell": lectureData["cell"],
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

  @override
  Future<void> setLecture(int cell, Lecture lecture) async{
    var time = 0;
    var day = cell - 1;
    while (day > 5) {
      day -= 5;
      time++;
    }
    await instance().child("user").child(uid)
    .child("timetable").child(time.toString())
    .child(day.toString()).set(<String, dynamic>{
      "cell": cell,
      "grade": lecture.grade,
      "id": lecture.id,
      "name": lecture.name,
      "staffs": lecture.staffList,
      "term": getTermId(lecture.term)
    });
  }

  @override
  Future<void> deleteLecture(int cell) async{
    var time = 0;
    var day = cell - 1;
    while (day > 5) {
      day -= 5;
      time++;
    }
    await instance().child("user").child(uid)
        .child("timetable").child(time.toString())
        .child(day.toString()).set(<String, dynamic>{
          "cell": cell,
          "grade": null,
          "id": null,
          "name": null,
          "staffs": [],
          "term": null
        });
    //print("Cell[$cell] is TIME = $time , DAY = $day.");
    // ${time}, ${day} is indicators corresponding to timetable.
  }
}