import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';

abstract class SubjectDataRepository {
  Future<dynamic> subjectDataList(Department department, int grade, Term term);
  Future<dynamic> subjectData(String name, Department department, int grade, Term term);
}