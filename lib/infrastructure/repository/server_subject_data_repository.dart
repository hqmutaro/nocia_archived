import 'dart:convert';

import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/domain/repository/subject_data_repository.dart';
import 'package:nocia/domain/term.dart';
import 'package:http/http.dart' as http;

class ServerSubjectDataRepository extends SubjectDataRepository implements Repository {

  final String apiUrl = "https://api.siketyan.dev/syllabus/subjects.php";
  final String schoolUrl = "?school=";
  final String departmentUrl = "&department=";
  final int schoolId = 51; // NIT, Okinawa College

  @override
  Future<dynamic> subjectDataList(Department department, Term term, int grade, {Course course}) async{
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
    var subjectList = await subjectDataList(department, term, grade);
    return subjectList.where((subjectData) => subjectData["name"] == name).first;
  }

  Future<dynamic> subjectDataId(int id, Department department, int grade, Term term) async{
    var subjectList = await subjectDataList(department, term, grade);
    return subjectList.where((subjectData) => subjectData["id"] == id.toString()).first;
  }
}