import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/dto/lecture_dto.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_list_repository.dart';
import 'package:nocia/presentation/timetable/cell/day_cell.dart';
import 'package:nocia/presentation/timetable/cell/lecture_cell.dart';
import 'package:nocia/presentation/timetable/cell/time_cell.dart';
import 'package:radial_button/widget/circle_floating_button.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class Timetable extends StatefulWidget {
  final User user;
  static String lectureValue;

  Timetable({@required this.user});

  @override
  _Timetable createState() => _Timetable();
}

class _Timetable extends State<Timetable> with SingleTickerProviderStateMixin {
  dynamic lectureDataList;
  String uid;

  @override
  void initState() {
    super.initState();
    Timetable.lectureValue = "";
    this.lectureDataList = widget.user.timetable;
    this.uid = widget.user.firebaseUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    var list = this.lectureDataList;
    var period1 = list[0]["data"];
    var period2 = list[1]["data"];
    var period3 = list[2]["data"];
    var period4 = list[3]["data"];
    var period5 = list[4]["data"];

    return Scaffold(
        backgroundColor: const Color(0xFFf0f0f0),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    TableRow(
                        children: [
                          Text(""),
                          DayCell("月"),
                          DayCell("火"),
                          DayCell("水"),
                          DayCell("木"),
                          DayCell("金")
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("1", "8:50", "10:20"),
                          LectureCell(1, period1["monday"], uid),
                          LectureCell(2, period1["tuesday"], uid),
                          LectureCell(3, period1["wednesday"], uid),
                          LectureCell(4, period1["thursday"], uid),
                          LectureCell(5, period1["friday"], uid)
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("2", "10:30", "12:00"),
                          LectureCell(6, period2["monday"], uid),
                          LectureCell(7, period2["tuesday"], uid),
                          LectureCell(8, period2["wednesday"], uid),
                          LectureCell(9, period2["thursday"], uid),
                          LectureCell(10, period2["friday"], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("3", "13:00", "14:30"),
                          LectureCell(11, period3["monday"], uid),
                          LectureCell(12, period3["tuesday"], uid),
                          LectureCell(13, period3["wednesday"], uid),
                          LectureCell(14, period3["thursday"], uid),
                          LectureCell(15, period3["friday"], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("4", "14:40", "16:10"),
                          LectureCell(16, period4["monday"], uid),
                          LectureCell(17, period4["tuesday"], uid),
                          LectureCell(18, period4["wednesday"], uid),
                          LectureCell(19, period4["thursday"], uid),
                          LectureCell(20, period4["friday"], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("5", "16:20", "17:50"),
                          LectureCell(21, period5["monday"], uid),
                          LectureCell(22, period5["tuesday"], uid),
                          LectureCell(23, period5["wednesday"], uid),
                          LectureCell(24, period5["thursday"], uid),
                          LectureCell(25, period5["friday"], uid),
                        ]
                    )
                  ]
                ),
                SizedBox(height: 40)
              ]
            )
        ),
      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Colors.transparent,
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0))
              ),
              child: Center(
                child: Icon(Icons.arrow_drop_up, color: Colors.white,),
              )
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: FutureBuilder(
            future: getSubjectDataList(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: Icon(Icons.star, color: snapshot.data[index] == Timetable.lectureValue ? Colors.yellowAccent : Colors.white),
                      title: Text(snapshot.data[index], style: TextStyle(color: Colors.white)),
                      onTap: () {
                        setState(() {
                          Timetable.lectureValue = snapshot.data[index];
                        });
                      },
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              }
              return Container();
            },
          ),
        ),
        smoothness: Smoothness.medium,// here
      ),
    );
  }

  Widget lectureCell(BuildContext context, int cell, Map<String, dynamic> lectureMap) {
    var subject = lectureMap["name"];
    var teacher = lectureMap["staffs"].toString();
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
        var time = 0;
        var day = cell - 1;
        while (day > 5) {
          day -= 5;
          time++;
        }
        setState(() {
          this.lectureDataList[time][day.toString()] = map;
        });
        await repository.setLecture(cell, lecture);
      },
      onLongPress: () {
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