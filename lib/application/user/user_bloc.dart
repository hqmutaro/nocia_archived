import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/application/user/user_state.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/firebase_timetable_repository.dart';
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
      var user = User(
          firebaseUser: firebaseUser,
          name: firebaseUser.displayName,
          photoUrl: firebaseUser.photoUrl,
          timetable: timetable
      );
      yield UserStream(user: user);
    }

  }
}