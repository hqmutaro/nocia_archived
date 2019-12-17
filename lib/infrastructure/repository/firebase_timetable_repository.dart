import 'package:flutter/material.dart';
import 'package:nocia/domain/lecture.dart';
import 'package:nocia/domain/repository/timetable_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/firestore_reference.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

class FirebaseTimetableRepository extends TimetableRepository{
  final String uid;

  FirebaseTimetableRepository({@required this.uid}): assert(uid != null);

  Future<dynamic> createTimetable() async{
    /*
    print("create");
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
   // await instance().child("user").child(uid).child("timetable").set(timetables);

     */

    print("create");
    var days = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday"
    ];
    var timetables = <Map<String, Map<String, dynamic>>>[]; // List: period(n) => <Map < key: day => value: timetable>>
    var timetable;

    var cell = 0;
    var range = List<int>.generate(5, (i) => i + 1);
    range.forEach((period) {
      timetable = <String, Map<String, dynamic>>{};
      days.forEach((day) {
        cell++; // plus 1
        //print("cell $cell");
        //print("day $day");
        /*
        timetables[period][day] = <String, dynamic>{
          "cell": cell,
          "grade": null,
          "id": null,
          "name": null,
          "staffs": [],
          "term": null
        };

         */
        timetable[day] = <String, dynamic>{
          "cell": cell,
          "grade": null,
          "id": null,
          "name": null,
          "staffs": [],
          "term": null
        };
        if (day == "friday") {
          timetables.add(timetable);
        }
      });
    });

    await instance().collection("user")
        .document(uid).collection("timetable")
        .document("period1").setData({"data" : timetables[0]});
    await instance().collection("user")
        .document(uid).collection("timetable")
        .document("period2").setData({"data" : timetables[1]});
    await instance().collection("user")
        .document(uid).collection("timetable")
        .document("period3").setData({"data" : timetables[2]});
    await instance().collection("user")
        .document(uid).collection("timetable")
        .document("period4").setData({"data" : timetables[3]});
    await instance().collection("user")
        .document(uid).collection("timetable")
        .document("period5").setData({"data" : timetables[4]});

    return timetables;
  }

  Future<dynamic> lectureTimetables() async{
    var user = await UserRepository().getUser();
    var info = await FirebaseUserInfoRepository(user: user).getUserInfo();
    print("aaaa");

    var snapshot = await instance().collection("user").document(uid).collection("timetable").getDocuments();
    var timetableList = snapshot.documents;
    if (snapshot.documents == null) {
      await createTimetable(); // Initialize Timetable
      var snapshot = await instance().collection("user").document(uid).collection("timetable").getDocuments();
      timetableList = snapshot.documents; // Get Data Again.
    }
    return timetableList.map((doc) => doc.data).toList();
  }

  @override
  Future<void> setLecture(int cell, Lecture lecture) async{
    var days = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday"
    ];
    var day = (cell % 5) == 0 ? days[4] : days[(cell % 5) - 1];
    var period = 1;
    while (cell > 5) {
      period++;
      cell -= 5;
    }
    instance().collection("user").document(uid)
    .collection("timetable").document("period" + period.toString())
    .updateData({"data.$day" : <String, dynamic>{
      "cell": cell,
      "grade": lecture.grade,
      "id": lecture.id,
      "name": lecture.name,
      "staffs": lecture.staffList,
      "term": getTermId(lecture.term)
      }
    });
  }

  @override
  Future<void> deleteLecture(int cell) async{
    var days = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday"
    ];
    var day = (cell % 5) == 0 ? days[4] : days[(cell % 5) - 1];
    var period = 1;
    while (cell > 5) {
      period++;
      cell -= 5;
    }
    instance().collection("user").document(uid)
        .collection("timetable").document("period" + period.toString())
        .updateData({"data.$day" : <String, dynamic>{
          "cell": cell,
          "grade": null,
          "id": null,
          "name": null,
          "staffs": [],
          "term": null
        }
    });
  }
}