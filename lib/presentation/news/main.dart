import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nocia/infrastructure/repository/firebase_news_repository.dart';
import 'package:nocia/presentation/news/bloc.dart';
import 'package:nocia/presentation/news/nocia_news/nocia_news_view.dart';
import 'package:nocia/presentation/news/school_news/school_news_builder.dart';
import 'package:nocia/presentation/news/school_news/school_news_view.dart';
import 'package:nocia/presentation/nocia_theme.dart';
import 'package:nocia/presentation/ui/header/wave_clipper_header.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'nocia_news/nocia_news_builder.dart';


class News extends StatefulWidget {

  const News({Key key}) : super(key: key);

  @override
  _News createState() => _News();
}

class _News extends State<News> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ニュース"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.settings),
          )
        ],
      ),
      drawer: Drawer(
          child: ListView(
            children: <Widget> [
              DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.indigo
                  ),
                  child: null
              ),
              ListTile(
                title: Text('First Menu Item'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Second Menu Item'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('About'),
                onTap: () {},
              ),
            ],
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            WaveClipperHeader(message: "新着情報"),
            BlocProvider<NewsBloc>(
              builder: (BuildContext context) => NewsBloc(),
              child: NociaNewsBuilder(),
            ),
            WaveClipperHeader(message: "学校の活動"),
            BlocProvider<NewsBloc>(
              builder: (BuildContext context) => NewsBloc(),
              child: SchoolNewsBuilder(),
            ),
          ],
        )
      )
    );
  }
}