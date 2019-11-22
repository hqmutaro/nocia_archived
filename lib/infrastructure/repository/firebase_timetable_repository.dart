import 'package:flutter/material.dart';
import 'package:nocia/domain/repository/timetable_repository.dart';
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