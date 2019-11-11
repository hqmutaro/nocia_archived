import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/lecture.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_list_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/infrastructure/service/service_email_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/infrastructure/service/service_twitter_auth.dart';
import 'package:nocia/presentation/introduction/intro_screen.dart';
import 'package:nocia/presentation/nocia_theme.dart';
import 'package:http/http.dart' as http;

class Display extends StatefulWidget {

  @override
  _Display createState() => _Display();
}

class _Display extends State<Display> {

  Map<String, Map<String, dynamic>> subjectMap;
  Draggable draggable;
  Map<String, dynamic> selected;

  @override
  void initState() {
    super.initState();
    subjectMap = {};
    selected = null;
    draggable = Draggable(child: Text(""), feedback: Icon(Icons.note_add));
  }

  @override
  Widget build(BuildContext context) {
    var userRepository = UserRepository();
    return FutureBuilder(
      future: userRepository.getUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          var repository = FirebaseTimetableRepository(uid: snapshot.data.uid);
          print(repository);
          return Scaffold(
              backgroundColor: const Color(0xFFf0f0f0),
              body: FutureBuilder(
                  future: repository.lectureTimetables(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                    if (snapshot2.hasData) {
                      var list = snapshot2.data;
                      var first = list[0];
                      var second = list[1];
                      var third = list[2];
                      var fourth = list[3];
                      var fifth = list[4];

                      return SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Table(
                                border: TableBorder.all(color: Colors.grey),
                                children: [
                                  TableRow(
                                      children: [
                                        Text(""),
                                        _createDayCell("月"),
                                        _createDayCell("火"),
                                        _createDayCell("水"),
                                        _createDayCell("木"),
                                        _createDayCell("金")
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        _createTimeCell("1", "8:50", "10:20"),
                                        /*
                                      _dragTarget("1"),
                                      _dragTarget("2"),
                                      _dragTarget("3"),
                                      _dragTarget("4"),
                                      _dragTarget("5"),
                                       */
                                        _lectureCell("1", first[0]),
                                        _lectureCell("2", first[1]),
                                        _lectureCell("3", first[2]),
                                        _lectureCell("4", first[3]),
                                        _lectureCell("5", first[4]),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        _createTimeCell("2", "10:30", "12:00"),
                                        /*
                                      _dragTarget("6"),
                                      _dragTarget("7"),
                                      _dragTarget("8"),
                                      _dragTarget("9"),
                                      _dragTarget("10"),
                                       */
                                        _lectureCell("6", second[0]),
                                        _lectureCell("7", second[1]),
                                        _lectureCell("8", second[2]),
                                        _lectureCell("9", second[3]),
                                        _lectureCell("10", second[4]),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        _createTimeCell("3", "13:00", "14:30"),
                                        /*
                                      _dragTarget("11"),
                                      _dragTarget("12"),
                                      _dragTarget("13"),
                                      _dragTarget("14"),
                                      _dragTarget("15"),
                                       */
                                        _lectureCell("11", third[0]),
                                        _lectureCell("12", third[1]),
                                        _lectureCell("13", third[2]),
                                        _lectureCell("14", third[3]),
                                        _lectureCell("15", third[4]),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        _createTimeCell("4", "14:40", "16:10"),
                                        /*
                                      _dragTarget("16"),
                                      _dragTarget("17"),
                                      _dragTarget("18"),
                                      _dragTarget("19"),
                                      _dragTarget("20"),
                                       */
                                        _lectureCell("16", fourth[0]),
                                        _lectureCell("17", fourth[1]),
                                        _lectureCell("18", fourth[2]),
                                        _lectureCell("19", fourth[3]),
                                        _lectureCell("20", fourth[4]),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        _createTimeCell("5", "16:20", "17:50"),
                                        /*
                                      _dragTarget("21"),
                                      _dragTarget("22"),
                                      _dragTarget("23"),
                                      _dragTarget("24"),
                                      _dragTarget("25"),
                                       */
                                        _lectureCell("21", fifth[0]),
                                        _lectureCell("22", fifth[1]),
                                        _lectureCell("23", fifth[2]),
                                        _lectureCell("24", fifth[3]),
                                        _lectureCell("25", fifth[4]),
                                      ]
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: draggable,
                              ),
                            ],
                          )
                      );
                    }
                    return Container(child: Center(child: CircularProgressIndicator()));
                  }
              ),
          );
        }
        return Container();
      },
    );
  }

  Container _createTimeCell(String period, String startTime, String finishTime) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                period,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6592C6)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                startTime,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4, left: 8),
              child: Text(
                finishTime,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Container _createDayCell(String day) {
    return Container(
      child: Center(child: Text(day, style: TextStyle(color: Colors.black),),),
      width: 30,
      height: 40,
    );
  }

  Draggable buildDraggable(String subject) {
    return Draggable(
      data: subject,
      child: Container(
        child: Center(child: Text(subject)),
        width: 30,
        height: 50,
      ),
      feedback: Icon(
        Icons.note_add,
        size: 90,
      )
    );
  }

  GestureDetector _lectureCell(String cell, Map<String, dynamic> lecture) {
    var subject = lecture["name"];
    var teacher = lecture["staffs"].toString();
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 2),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          subject ?? "",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        height: 100,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            subject == null ? "" : teacher.substring(0, 2) + "…",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: subject == null ? Color(0xFFEFEFEF) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                        width: 50,
                      )
                    ],
                  )
              ),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(width: 4.0, color: subject == null ? Color(0xFFEFEFEF) : Colors.blue)),
                color: subject == null ? const Color(0xFFEFEFEF) : Color(0xFFBAE3F9),
              ),
              height: 150,
              width: 60,
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 5),
                child: Text(
                  subject + "\n $teacher",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 60),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text("閉じる"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("削除"),
                      onPressed: () {
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
      },
      onDoubleTap: () {
      },
      onLongPress: () {
      },
    );
  }
  
  DragTarget _dragTarget(String cell) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        print("DragTarget.builder: candidateData: $candidateData, rejectedData: $rejectedData");
        if (this.subjectMap[cell] == null) {
          this.subjectMap[cell] = {
            "name" : null,
            "staffs" : [""]
          };
        }
        var cellData = this.subjectMap[cell];

        var subject = cellData["name"];
        var teacher = cellData["staffs"].first;
        if (teacher.length > 3) {
          teacher = teacher.substring(0, 2) + "…";
        }

        return GestureDetector(
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 2),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              subject ?? "",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            height: 100,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                subject == null ? "" : teacher.substring(0, 2) + "…",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: subject == null ? Color(0xFFEFEFEF) : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(2.0)),
                            ),
                            width: 50,
                          )
                        ],
                      )
                  ),
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(width: 4.0, color: subject == null ? Color(0xFFEFEFEF) : Colors.blue)),
                    color: subject == null ? const Color(0xFFEFEFEF) : Color(0xFFBAE3F9),
                  ),
                  height: 150,
                  width: 60,
                ),
              ],
            ),
          ),
          onTap: () async{
            if (subject != null) {
              var subjectDataMap = await getSubjectData(subject);
              showDialog(
                context: context,
                builder: (context) {
                  var classInfo = "";
                  var classes = subjectDataMap["classes"] as List;
                  classes.forEach((classData) {
                    classInfo += classData["grade"].toString() + "学年\n";
                    if (getTerm(classData["term"]) == Term.First) {
                      classInfo += "前期\n";
                    }
                    else {
                      classInfo += "後期\n";
                    }
                    classInfo += "単位数: " + classData["count"].toString() + "\n\n";
                  });
                  return SimpleDialog(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 5),
                        child: Text(
                            subject,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                      ),
                      Text(subjectMap[cell]["staffs"].toString()),
                      Text(subjectDataMap["types"].toString()),
                      Text(classInfo),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 60),
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text("閉じる"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text("削除"),
                              onPressed: () {
                                setState(() {
                                  subjectMap[cell] = <String, dynamic>{
                                    "name" : null,
                                    "staffs" : [""]
                                  };
                                  Navigator.pop(context);
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
            );
            }
          },
          onDoubleTap: () {
            setState(() {
              subjectMap[cell] = selected;
            });
          },
          onLongPress: () {
            setState(() {
              subjectMap[cell] = <String, dynamic>{
                "name" : null,
                "staffs" : [""]
              };
            });
          },
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async{
        var subjectDataMap = await getSubjectData(data);
        setState(() {
          subjectMap[cell] = {
            "name" : subjectDataMap["name"],
            "staffs" : subjectDataMap["staffs"]
          };
        });
      },
    );
  }

  Future<dynamic> getSubjectDataList() async{
    var repository = ServerSubjectListRepository();
    var subjectList = await repository.subjectList(Department.MEDIA_INFORMATION_ENGINEERING, 5, Term.Final);
    return subjectList;
  }

  Future<dynamic> getSubjectData(String subject) async{
    var repository = ServerSubjectDataRepository();
    var subjectData = repository.subjectData(subject, Department.MEDIA_INFORMATION_ENGINEERING, 5, Term.Final);
    return subjectData;
  }
}