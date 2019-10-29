import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocia/presentation/nocia.dart';
import 'package:http/http.dart' as http;

class Display extends StatefulWidget {

  @override
  _Display createState() => _Display();
}

class _Display extends State<Display> {

  Map<String, Map<String, dynamic>> subjectMap;
  Draggable draggable;
  Map<String, dynamic> selected;

  List<String> subjectList = [
    "化学",
    "基礎数学Ⅰ",
    "基礎数学Ⅱ",
    "プログラミングⅠ",
    "メディア情報工学セミナー",
    "スポーツ実技Ⅰ",
    "情報技術の基礎",
    "国語Ⅰ",
    "ECPⅠ",
    "ESKⅠ",
    "ECMⅠ",
    "LHR",
    "デザイン",
    "中国語",
    "音楽",
    "物理Ⅰ",
    "メディアコンテンツ基礎",
    "アルゴリズムとデータ構造"
  ];

  @override
  void initState() {
    super.initState();
    subjectMap = {};
    selected = null;
    draggable = Draggable(child: Text(""), feedback: Icon(Icons.note_add));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f0f0),
      drawer: Nocia.getDrawer(),
      appBar: Nocia.getAppBar("時間割"),
      body: SingleChildScrollView(
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
                      _dragTarget("1"),
                      _dragTarget("2"),
                      _dragTarget("3"),
                      _dragTarget("4"),
                      _dragTarget("5")
                    ]
                ),
                TableRow(
                    children: [
                      _createTimeCell("2", "10:30", "12:00"),
                      _dragTarget("6"),
                      _dragTarget("7"),
                      _dragTarget("8"),
                      _dragTarget("9"),
                      _dragTarget("10")
                    ]
                ),
                TableRow(
                    children: [
                      _createTimeCell("3", "13:00", "14:30"),
                      _dragTarget("11"),
                      _dragTarget("12"),
                      _dragTarget("13"),
                      _dragTarget("14"),
                      _dragTarget("15")
                    ]
                ),
                TableRow(
                    children: [
                      _createTimeCell("4", "14:40", "16:10"),
                      _dragTarget("16"),
                      _dragTarget("17"),
                      _dragTarget("18"),
                      _dragTarget("19"),
                      _dragTarget("20")
                    ]
                ),
                TableRow(
                    children: [
                      _createTimeCell("5", "16:20", "17:50"),
                      _dragTarget("21"),
                      _dragTarget("22"),
                      _dragTarget("23"),
                      _dragTarget("24"),
                      _dragTarget("25")
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
      ),
      floatingActionButton: FutureBuilder(
        future: getSubjectDataList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return PopupMenuButton<String>(
              initialValue: null,
              onSelected: (subject) {
                getSubjectData(subject)
                    .then((subjectDataMap) {
                  setState(() {
                    draggable = Draggable(child: Text(subject), feedback: Icon(Icons.note_add), data: subject);
                    selected = <String, dynamic>{
                      "name" : subject,
                      "staffs" : subjectDataMap["staffs"]
                    };
                  });
                });
              },
              itemBuilder: (BuildContext context) {
                var items = <PopupMenuItem<String>>[];
                snapshot.data.forEach((subjectDataMap) {
                  items.add(
                      PopupMenuItem(
                        child: Text(subjectDataMap["name"]),
                        value: subjectDataMap["name"],
                      )
                  );
                });
                print(items);
                return items;
              },
            );
          }
          return Container();
        },
      )
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
      child: Center(child: Text(day)),
      width: 30,
      height: 20,
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
          onTap: () {
            if (subject != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: <Widget>[
                      Text(subject),
                      Text(subjectMap[cell]["staffs"].toString()),
                      FloatingActionButton(
                        child: Text("削除"),
                        onPressed: () {
                          setState(() {
                            subjectMap[cell] = <String, dynamic>{
                              "name" : null,
                              "staffs" : [""]
                            };
                          });
                        },
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
        print("DragTarget.onWillAccept: data: $data");
        return true;
      },
      onAccept: (data) async{
        print("DragTarget.onAccept: data: $data");
        var subjectDataMap = await getSubjectData(data);
        setState(() {
          subjectMap[cell] = {
            "name" : subjectDataMap["name"],
            "staffs" : subjectDataMap["staffs"]
          };
        });
      },
      onLeave: (data) {
        print("DragTarget.onLeave: data: $data");
      },
    );
  }

  Future<dynamic> getSubjectDataList() async{
      try {
        var response = await http.get("https://api.siketyan.dev/syllabus/subjects.php?school=51&department=13");
        return json.decode(response.body) as List;
      }
      catch (e) {
        print(e);
        return await getSubjectDataList();
      }
  }

  Future<Map<String, dynamic>> getSubjectData(String subject) async{
    try {
      var response = await http.get("https://api.siketyan.dev/syllabus/subjects.php?school=51&department=13");
      var subjectDataList =  json.decode(response.body) as List;
      var aaa = subjectDataList
          .where((subjectDataMap) => subjectDataMap["name"] == subject)
      .first;
      print("aiuo $aaa");
      return aaa;
    }
    catch (e) {
      return await getSubjectData(subject);
    }
  }
}