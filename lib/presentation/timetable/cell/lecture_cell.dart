import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/dto/lecture_dto.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

import '../main.dart';

class LectureCell extends StatefulWidget {
  final int cell;
  final Map<dynamic, dynamic> lecture;
  final String uid;
  final String selectLecture;

  LectureCell(
      this.cell,
      this.lecture,
      this.uid,
      this.selectLecture
      ):  assert(cell != null),
        assert(lecture != null),
        assert(uid != null);

  @override
  _LectureCell createState() => _LectureCell();
}

class _LectureCell extends State<LectureCell> {
  Map<dynamic, dynamic> lecture;
  Color defaultColor;

  @override
  void initState() {
    super.initState();
    this.lecture = widget.lecture;
    this.defaultColor = Color(0xFFEFEFEF);
  }

  @override
  Widget build(BuildContext context) {
    var subject = this.lecture["name"];
    var teacher = this.lecture["staffs"].toString();
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
                            subject == null ? "" : teacher.substring(1, 3) + "…",
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
                border: Border(left: BorderSide(width: 4.0, color: subject == null ? this.defaultColor : Colors.blue)),
                color: subject == null ? this.defaultColor : Color(0xFFBAE3F9),
              ),
              height: 150,
              width: 60,
            ),
          ],
        ),
      ),
      onTap: () {
        if (subject != null) {
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
                        onPressed: () async{
                          var repository = FirebaseTimetableRepository(uid: widget.uid);
                          await repository.deleteLecture(widget.cell);
                          var map = <String, dynamic>{
                            "name": null,
                            "id": null,
                            "staffs": null,
                            "grade": null,
                            "term": null
                          };
                          setState(() {
                            this.lecture = map;
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          });
        }
      },
      onDoubleTap: () async{
        if (subject == null) {
          setState(() => this.defaultColor = Colors.deepOrangeAccent);
          var repository = FirebaseTimetableRepository(uid: widget.uid);
          var data = await getSubjectData(widget.selectLecture);
          var map = <String, dynamic>{
            "name": data["name"],
            "id": data["id"],
            "staffs": data["staffs"],
            "grade": data["classes"][0]["grade"],
            "term": data["classes"][0]["term"]
          };
          var lecture = LectureDTO.decode(map);
          setState(() {
            this.defaultColor = Color(0xFFEFEFEF);
            this.lecture = map;
          });
          await repository.setLecture(widget.cell, lecture);
        }
      },
      onLongPress: () async{
        if (subject != null) {
          var repository = FirebaseTimetableRepository(uid: widget.uid);
          await repository.deleteLecture(widget.cell);
          var map = <String, dynamic>{
            "name": null,
            "id": null,
            "staffs": null,
            "grade": null,
            "term": null
          };
          setState(() {
            this.lecture = map;
          });
        }
      },
    );
  }

  Future<dynamic> getSubjectData(String subject) async{
    var user = await UserRepository().getUser();
    var userInfoRepository = FirebaseUserInfoRepository(user: user);
    var data = await userInfoRepository.getUserInfo();
    var subjectDataRepository = ServerSubjectDataRepository();
    var department = getDepartment(data["department"]);
    var subjectData = subjectDataRepository.subjectData(
        subject,
        department,
        data["grade"],
        getTerm(data["term"]),
        course: department == Department.ADVANCED ? getCourse((data["course"])) : null
    );
    return subjectData;
  }
}