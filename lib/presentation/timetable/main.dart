import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/domain/user.dart';
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

  @override
  void initState() {
    super.initState();
    Timetable.lectureValue = "";
  }

  @override
  Widget build(BuildContext context) {
    var list = widget.user.timetable;
    var period1 = list[0];
    var period2 = list[1];
    var period3 = list[2];
    var period4 = list[3];
    var period5 = list[4];

    var uid = widget.user.firebaseUser.uid;

    return Scaffold(
        backgroundColor: const Color(0xFFf0f0f0),
        body:SingleChildScrollView(
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
                          LectureCell(1, period1[0], uid),
                          LectureCell(2, period1[1], uid),
                          LectureCell(3, period1[2], uid),
                          LectureCell(4, period1[3], uid),
                          GestureDetector(child: LectureCell(5, period1[4], uid), onTap: () => print("aaaaaaaaaaa"),)
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("2", "10:30", "12:00"),
                          LectureCell(6, period2[0], uid),
                          LectureCell(7, period2[1], uid),
                          LectureCell(8, period2[2], uid),
                          LectureCell(9, period2[3], uid),
                          LectureCell(10, period2[4], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("3", "13:00", "14:30"),
                          LectureCell(11, period3[0], uid),
                          LectureCell(12, period3[1], uid),
                          LectureCell(13, period3[2], uid),
                          LectureCell(14, period3[3], uid),
                          LectureCell(15, period3[4], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("4", "14:40", "16:10"),
                          LectureCell(16, period4[0], uid),
                          LectureCell(17, period4[1], uid),
                          LectureCell(18, period4[2], uid),
                          LectureCell(19, period4[3], uid),
                          LectureCell(20, period4[4], uid),
                        ]
                    ),
                    TableRow(
                        children: [
                          TimeCell("5", "16:20", "17:50"),
                          LectureCell(21, period5[0], uid),
                          LectureCell(22, period5[1], uid),
                          LectureCell(23, period5[2], uid),
                          LectureCell(24, period5[3], uid),
                          LectureCell(25, period5[4], uid),
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

  Future<dynamic> getSubjectDataList() async{
    var repository = ServerSubjectListRepository();
    var subjectList = await repository.subjectList(Department.MEDIA_INFORMATION_ENGINEERING, 5, Term.Final);
    return subjectList;
  }
}