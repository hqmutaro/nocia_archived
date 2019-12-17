import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Initial extends UserState {}

class UserStream extends UserState {
  final User user;

  const UserStream({@required this.user});

  @override
  List<Object> get props => [user];
}