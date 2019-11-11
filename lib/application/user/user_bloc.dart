import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';

abstract class UserEvent{}

class UserStream {
  final User user;

  UserStream({@required this.user});
}

class RequestUser implements UserEvent {
}

class UserBloc extends Bloc<UserEvent, UserStream> {

  @override
  UserStream get initialState => UserStream(user: null);

  @override
  Stream<UserStream> mapEventToState(UserEvent event) async*{
    if (event is RequestUser) {
      yield UserStream(user: null);
    }
  }
}