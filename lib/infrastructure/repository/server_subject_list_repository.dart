import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/domain/repository/subject_list_repository.dart';
import 'package:nocia/domain/term.dart';

import 'package:nocia/infrastructure/repository/server_subject_data_repository.dart';

class ServerSubjectListRepository extends SubjectListRepository implements Repository {

  @override
  Future<List<dynamic>> subjectList(Department department, int grade, Term term, {Course course}) async{
    var repository = ServerSubjectDataRepository();
    var subjectDataList = await repository.subjectDataList(department, term, grade, course: course);
    return subjectDataList.map((subjectDataMap) => subjectDataMap["name"]).toList();
  }
}