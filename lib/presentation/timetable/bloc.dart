import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/server_subject_list_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();

  @override
  List<Object> get props => [];
}

class LoadTimetable extends TimetableEvent {}

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

class TimetableLoaded extends TimetableState {

  final List<dynamic> timetable;
  final List<dynamic> lectureList;

  const TimetableLoaded(
      this.timetable,
      this.lectureList
  ): assert(timetable != null),
     assert(lectureList != null);
}

class Initial extends TimetableState {}

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {

  @override
  TimetableState get initialState => Initial();

  @override
  Stream<TimetableState> mapEventToState(TimetableEvent event) async*{
    if (event is LoadTimetable) {
      var userRepository = UserRepository();
      var firebaseUser = await userRepository.getUser();
      var userInfoRepository = FirebaseUserInfoRepository(user: firebaseUser);
      var data = await userInfoRepository.getUserInfo();
      var timetableRepository = FirebaseTimetableRepository(uid: firebaseUser.uid);
      var timetable = await timetableRepository.lectureTimetables();

      var subjectListRepository = ServerSubjectListRepository();

      var department = getDepartment(data["department"]);
      var lectureList = await subjectListRepository.subjectList(
          department,
          data["grade"],
          getTerm(data["term"]),
          course: department == Department.ADVANCED ? getCourse(data["course"]) : null
      );

      yield TimetableLoaded(timetable, lectureList);
    }
  }
}