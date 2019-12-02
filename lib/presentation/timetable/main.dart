import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/presentation/timetable/bloc.dart';
import 'package:nocia/presentation/timetable/cell/lecture_cell.dart';
import 'package:nocia/presentation/timetable/cell/time_cell.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import 'cell/day_cell.dart';

class Sample extends StatefulWidget {
  final FirebaseUser firebaseUser;

  Sample({@required this.firebaseUser}): assert(firebaseUser != null);

  @override
  _Sample createState() => _Sample();
}

class _Sample extends State<Sample> with SingleTickerProviderStateMixin {

  String selectLecture;

  @override
  void initState() {
    super.initState();
    this.selectLecture = "";
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TimetableBloc>(context);
    _bloc.add(LoadTimetable());
    return BlocBuilder<TimetableBloc, TimetableState>(
      builder: (BuildContext context, TimetableState snapshot) {
        if (snapshot is TimetableLoaded) {
          var timetable = snapshot.timetable;
          var period1 = timetable[0]["data"]; // 1限目の1週間分の講義 (月、火、水、木、金)
          var period2 = timetable[1]["data"]; // 2限目の1週間分の講義 (月、火、水、木、金)
          var period3 = timetable[2]["data"]; // 3限目の1週間分の講義 (月、火、水、木、金)
          var period4 = timetable[3]["data"]; // 4限目の1週間分の講義 (月、火、水、木、金)
          var period5 = timetable[4]["data"]; // 5限目の1週間分の講義 (月、火、水、木、金)

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
                              lecture(1, period1["monday"]),
                              lecture(2, period1["tuesday"]),
                              lecture(3, period1["wednesday"]),
                              lecture(4, period1["thursday"]),
                              lecture(5, period1["friday"])
                            ]
                        ),
                        TableRow(
                            children: [
                              TimeCell("2", "10:30", "12:00"),
                              lecture(6, period2["monday"]),
                              lecture(7, period2["tuesday"]),
                              lecture(8, period2["wednesday"]),
                              lecture(9, period2["thursday"]),
                              lecture(10, period2["friday"])
                            ]
                        ),
                        TableRow(
                            children: [
                              TimeCell("3", "13:00", "14:30"),
                              lecture(11, period3["monday"]),
                              lecture(12, period3["tuesday"]),
                              lecture(13, period3["wednesday"]),
                              lecture(14, period3["thursday"]),
                              lecture(15, period3["friday"])
                            ]
                        ),
                        TableRow(
                            children: [
                              TimeCell("4", "14:40", "16:10"),
                              lecture(16, period4["monday"]),
                              lecture(17, period4["tuesday"]),
                              lecture(18, period4["wednesday"]),
                              lecture(19, period4["thursday"]),
                              lecture(20, period4["friday"])
                            ]
                        ),
                        TableRow(
                            children: [
                              TimeCell("5", "16:20", "17:50"),
                              lecture(21, period5["monday"]),
                              lecture(22, period5["tuesday"]),
                              lecture(23, period5["wednesday"]),
                              lecture(24, period5["thursday"]),
                              lecture(25, period5["friday"])
                            ]
                        )
                      ]
                  ),
                  SizedBox(height: 40)
                ],
              ),
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
                            topRight: const Radius.circular(40.0)
                        )
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_drop_up, color: Colors.white,),
                    )
                )
              ),
              body: Container(
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      leading: Icon(Icons.star, color: snapshot.lectureList[index] == this.selectLecture ? Colors.yellowAccent : Colors.white),
                      title: Text(snapshot.lectureList[index], style: TextStyle(color: Colors.white)),
                      onTap: () {
                        setState(() {
                          this.selectLecture = snapshot.lectureList[index];
                        });
                      },
                    );
                  },
                  itemCount: snapshot.lectureList.length
                )
              ),
              smoothness: Smoothness.medium
            )
          );
        }
        return Container();
      }
    );
  }

  LectureCell lecture(int cell, Map<dynamic, dynamic> weekLectureMap) =>
      LectureCell(
          cell,
          weekLectureMap,
          widget.firebaseUser.uid,
          this.selectLecture
      );
}