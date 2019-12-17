import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';

abstract class SubjectListRepository {
  Future<dynamic> subjectList(Department department, int grade, Term term, {Course course});
}