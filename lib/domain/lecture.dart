import 'package:flutter/cupertino.dart';
import 'package:nocia/domain/entity.dart';
import 'package:nocia/domain/term.dart';

class Lecture extends Entity {

  final String name;
  final String id;
  final List<dynamic> staffList;
  final num grade;
  final Term term;

  Lecture({
    @required this.name,
    @required this.id,
    @required this.staffList,
    @required this.grade,
    @required this.term
  }):
      assert(name != null),
      assert(id != null),
      assert(staffList != null),
      assert(grade != null),
      assert(term != null);
}