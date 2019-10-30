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
  Future<dynamic> subjectDataList(Department department, int grade, Term term, {Course course}) async{
    var departmentId;
    if (department == Department.ADVANCED) {
      departmentId = getCourseId(course);
    }
    else {
      departmentId = getDepartmentId(department);
    }
    var response = await http.get(apiUrl + schoolUrl + schoolId.toString() + departmentUrl + departmentId.toString());
    var subjectList = json.decode(response.body) as List<dynamic>;
    var subjectDataList = <Map<String, dynamic>>[];
    subjectList.forEach((subjectData) {
      var classes = subjectData["classes"];
      classes.forEach((classData) {
        if ((classData["grade"] == grade) && (getTerm(classData["term"]) == term)) {
          subjectDataList.add(subjectData);
        }
      });
    });
    return subjectDataList;
  }

  @override
  Future<dynamic> subjectData(String name, Department department, int grade, Term term) async{
    var subjectList = await subjectDataList(department, grade, term);
    return subjectList.where((subjectData) => subjectData["name"] == name).first;
  }
}