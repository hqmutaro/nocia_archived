import 'package:flutter/cupertino.dart';
import 'package:nocia/domain/entity.dart';
import 'package:nocia/domain/term.dart';

class Subject extends Entity {

  final String name;
  final List<String> staffList;
  final num grade;
  final Term term;

  Subject({
    @required this.name,
    @required this.staffList,
    @required this.grade,
    @required this.term
  }):
      assert(name != null),
      assert(staffList != null),
      assert(grade != null),
      assert(term != null);
}