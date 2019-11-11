import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';

abstract class SubjectDataRepository {
  Future<dynamic> subjectDataList(Department department, Term term, int grade, {Course course});
  Future<dynamic> subjectData(String name, Department department, int grade, Term term);
}