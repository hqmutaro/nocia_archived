import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/application/user/user_state.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/user_info_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/presentation/ui/drawer/nocia_drawer.dart';

class Config extends StatefulWidget {
  final User user;

  Config({@required this.user}): assert(user != null);

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
  UserInfoRepository userInfoRepository;

  bool isAdvanced;
  int departmentValue;
  int courseValue;
  int mainGradeValue;
  int advancedGradeValue;
  int termValue;

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
    userInfoRepository = FirebaseUserInfoRepository(user: widget.user.firebaseUser);
    departmentValue = getDepartmentId(widget.user.department) - 11;
    isAdvanced = widget.user.department == Department.ADVANCED;
    var course = widget.user.course;
    courseValue = course == Course.NONE ? 0 : getCourseId(course) - 21;
    if (isAdvanced) {
      advancedGradeValue = !(widget.user.grade <= 1) ? 0 : widget.user.grade;
    }
    else {
      mainGradeValue = widget.user.grade;
    }
    termValue = getTermId(widget.user.term);
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
              drawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: NociaDrawer(user: stream.user),
              ),
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
                                                userInfoRepository.updateUserData(key: "department", value: index + 11);
                                                setState(() {
                                                  if (index == 4) {
                                                    isAdvanced = true;
                                                    advancedGradeValue = 1;
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
                                                userInfoRepository.updateUserData(key: "course", value: index + 21);
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
                                                userInfoRepository.updateUserData(key: "grade", value: index + 1);
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 12),
                                          child: DirectSelectList<String>(
                                              values: terms,
                                              defaultItemIndex: termValue,
                                              itemBuilder: (String value) => getDropDownMenuItem(value),
                                              focusedItemDecoration: _getDslDecoration(),
                                              onItemSelectedListener: (item, index, context) {
                                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("学期: $item")));
                                                userInfoRepository.updateUserData(key: "term", value: index);
                                                setState(() {
                                                  termValue = index;
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