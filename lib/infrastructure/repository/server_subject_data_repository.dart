import 'dart:convert';

import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/subject_data_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:http/http.dart' as http;

class ServerSubjectDataRepository extends SubjectDataRepository {

  final String apiUrl = "https://api.siketyan.dev/syllabus/subjects.php";
  final String schoolUrl = "?school=";
  final String departmentUrl = "&department=";
  final int schoolId = 51;

  @override
  Future<List<dynamic>> subjectData(Department department, int grade, Term term, {Course course}) async{
    var departmentId;
    if (department == Department.ADVANCED) {
      departmentId = getCourseId(course);
    }
    else {
      departmentId = getDepartmentId(department);
    }
    var response = await http.get(apiUrl + schoolUrl + schoolId.toString() + departmentUrl + departmentId.toString());
    var jsonData = json.decode(response.body) as List<dynamic>;
    return jsonData;
  }
}