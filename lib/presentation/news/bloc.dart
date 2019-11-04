import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/infrastructure/repository/firebase_news_repository.dart';
import 'package:nocia/infrastructure/repository/server_rss_repository.dart';

abstract class NewsEvent{}

class NewsStream {
  final Repository repository;

  NewsStream({@required this.repository});
}

class NotUpdated implements NewsEvent{
  final Repository repository = null;
}

class UpdateNociaNews implements NewsEvent{
  final FirebaseNewsRepository repository = FirebaseNewsRepository();
}

class UpdateSchoolNews implements NewsEvent {
  final ServerRSSRepository repository = ServerRSSRepository();
}

class NewsBloc extends Bloc<NewsEvent, NewsStream> {

  @override
  NewsStream get initialState => NewsStream(repository: NotUpdated().repository);

  @override
  Stream<NewsStream> mapEventToState(NewsEvent event) async*{
    if (event is UpdateNociaNews) {
      yield NewsStream(repository: event.repository);
    }
    if (event is UpdateSchoolNews) {
      yield NewsStream(repository: event.repository);
    }
  }
}