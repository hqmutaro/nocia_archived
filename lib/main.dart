import 'package:flutter/material.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/server_subject_list_repository.dart';
import 'package:nocia/presentation/app.dart';

void main() async{
  runApp(App());
  var repository = ServerSubjectListRepository();
  var subjectList = await repository.subjectList(Department.MEDIA_INFORMATION_ENGINEERING, 1, Term.First);
  print(subjectList);
}