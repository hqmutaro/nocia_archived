import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';

abstract class SubjectDataRepository {
  Future<List<dynamic>> subjectData(Department department, int grade, Term term);
}