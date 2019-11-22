import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/application/user/user_state.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/presentation/ui/drawer/nocia_drawer.dart';

class Config extends StatefulWidget {
  @override
  _Config createState() => _Config();
}

class _Config extends State<Config> {
  final departments = [
    "機械システム工学科",
    "情報通信システム工学科",
    "メディア情報工学科",
    "生物資源工学科",
    "専攻科"
  ];
  final courses = [
    "機械システム工学コース",
    "電子通信システム工学コース",
    "情報工学コース",
    "生物資源工学コース"
  ];
  final mainGrades = [
    "1学年",
    "2学年",
    "3学年",
    "4学年",
    "5学年"
  ];
  final advancedGrades = [
    "1学年",
    "2学年"
  ];
  final terms = [
    "前期",
    "後期"
  ];

  bool isAdvanced = false;
  int departmentValue = 0;
  int courseValue = 0;
  int mainGradeValue = 0;
  int advancedGradeValue = 0;
  int termValue = 0;

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.add(RequestUser());
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, stream) {
          if (stream is UserStream) {
            if (stream == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                  title: Text("設定"),
                  centerTitle: true
              ),
              drawer: NociaDrawer(user: stream.user),
              body: DirectSelectContainer(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              margin: EdgeInsets.only(left: 4),
                              child: Text("学科"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: DirectSelectList<String>(
                                              values: departments,
                                              defaultItemIndex: departmentValue,
                                              itemBuilder: (String value) => getDropDownMenuItem(value),
                                              focusedItemDecoration: _getDslDecoration(),
                                              onItemSelectedListener: (item, index, context) {
                                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("学科: $item")));
                                                setState(() {
                                                  if (index == 4) {
                                                    isAdvanced = true;
                                                  }
                                                  else {
                                                    isAdvanced = false;
                                                  }
                                                  departmentValue = index;
                                                });
                                              }
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.unfold_more,
                                        color: Colors.black38,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            isAdvanced ? Container(
                              alignment: AlignmentDirectional.centerStart,
                              margin: EdgeInsets.only(left: 4),
                              child: Text("コース"),
                            ) : Container(),
                            isAdvanced ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: DirectSelectList<String>(
                                              values: courses,
                                              defaultItemIndex: courseValue,
                                              itemBuilder: (String value) => getDropDownMenuItem(value),
                                              focusedItemDecoration: _getDslDecoration(),
                                              onItemSelectedListener: (item, index, context) {
                                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("コース: $item")));
                                                setState(() {
                                                  courseValue = index;
                                                });
                                              }
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.unfold_more,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ) : Container(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              margin: EdgeInsets.only(left: 4),
                              child: Text("学年"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: DirectSelectList<String>(
                                              values: isAdvanced ? advancedGrades : mainGrades,
                                              defaultItemIndex: isAdvanced ? advancedGradeValue : mainGradeValue,
                                              itemBuilder: (String value) => getDropDownMenuItem(value),
                                              focusedItemDecoration: _getDslDecoration(),
                                              onItemSelectedListener: (item, index, context) {
                                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("学年: $item")));
                                                setState(() {
                                                  if (isAdvanced) {
                                                    advancedGradeValue = index;
                                                  }
                                                  else {
                                                    mainGradeValue = index;
                                                  }
                                                });
                                              }
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.unfold_more,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              margin: EdgeInsets.only(left: 4, bottom: 8, top: 8),
                              child: Text("学期"),
                            ),
                            CustomRadioButton(
                              buttonColor: Theme.of(context).buttonColor,
                              buttonLables: ["前期", "後期"],
                              buttonValues: [0, 1],
                              radioButtonValue: (value) {
                                setState(() {
                                  termValue = value;
                                });
                              },
                              selectedColor: Theme.of(context).accentColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        }
    );
  }
}