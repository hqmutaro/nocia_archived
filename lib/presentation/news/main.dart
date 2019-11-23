import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/presentation/news/bloc.dart';
import 'package:nocia/presentation/news/school_news/school_news_builder.dart';
import 'package:nocia/presentation/ui/header/wave_clipper_header.dart';

import 'nocia_news/nocia_news_builder.dart';


class News extends StatefulWidget {

  News({Key key}) : super(key: key);

  @override
  _News createState() => _News();
}

class _News extends State<News> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                WaveClipperHeader(message: "Nocia"),
                BlocProvider<NewsBloc>(
                  builder: (BuildContext context) => NewsBloc(),
                  child: NociaNewsBuilder(),
                ),
                WaveClipperHeader(message: "学校の活動"),
                BlocProvider<NewsBloc>(
                  builder: (BuildContext context) => NewsBloc(),
                  child: SchoolNewsBuilder(),
                )
              ],
            )
        )
    );
  }
}