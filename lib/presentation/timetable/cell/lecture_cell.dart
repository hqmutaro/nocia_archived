import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/dto/lecture_dto.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';

import '../main.dart';

class LectureCell extends StatelessWidget {
  final int cell;
  final Map<String, dynamic> lecture;
  final String uid;

  const LectureCell(
    this.cell,
    this.lecture,
    this.uid
  ):  assert(cell != null),
      assert(lecture != null),
      assert(uid != null);

  @override
  Widget build(BuildContext context) {
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
                          var repository = FirebaseTimetableRepository(uid: uid);
                          await repository.deleteLecture(cell);
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
        var repository = FirebaseTimetableRepository(uid: uid);
        var data = await getSubjectData(Timetable.lectureValue);
        var map = <String, dynamic>{
          "name": data["name"],
          "id": data["id"],
          "staffs": data["staffs"],
          "grade": data["classes"][0]["grade"],
          "term": data["classes"][0]["term"]
        };
        var lecture = LectureDTO.decode(map);
        await repository.setLecture(cell, lecture);
        var bloc = BlocProvider.of<UserBloc>(context);
        bloc.add(RequestUser());
      },
      onLongPress: () {
      },
    );
  }

  Future<dynamic> getSubjectData(String subject) async{
    var repository = ServerSubjectDataRepository();
    var subjectData = repository.subjectData(subject, Department.MEDIA_INFORMATION_ENGINEERING, 5, Term.Final);
    return subjectData;
  }
}