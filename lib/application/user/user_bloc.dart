import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/application/user/user_state.dart';
import 'package:nocia/domain/department.dart';
import 'package:nocia/domain/term.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  @override
  UserState get initialState => Initial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    var repository = UserRepository();
    if (event is RequestUser) {
      var firebaseUser = await repository.getUser();
      var timetableRepository = FirebaseTimetableRepository(uid: firebaseUser.uid);
      var timetable = await timetableRepository.lectureTimetables();
      var userInfoRepository = FirebaseUserInfoRepository(user: firebaseUser);
      var userData = await userInfoRepository.getUserInfo();
      print("data $userData");
      print(getCourse(userData["course"]));

      var user = User(
          firebaseUser: firebaseUser,
          name: firebaseUser.displayName,
          photoUrl: firebaseUser.photoUrl,
          department: getDepartment(userData["department"]),
          course: getCourse(userData["course"]),
          grade: userData["grade"],
          term: getTerm(userData["term"]),
          timetable: timetable
      );
      print("suss $user");
      yield UserStream(user: user);
    }

  }
}