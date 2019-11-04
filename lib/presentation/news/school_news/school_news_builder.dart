import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/infrastructure/repository/server_rss_repository.dart';
import 'package:nocia/presentation/news/bloc.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:nocia/presentation/news/school_news/school_news_tile.dart';

class SchoolNewsBuilder extends StatelessWidget {

  SchoolNewsBuilder();

  @override
  Widget build(BuildContext context) {
    final _newsBloc = BlocProvider.of<NewsBloc>(context);
    _newsBloc.add(UpdateSchoolNews());
    return BlocBuilder<NewsBloc, NewsStream>(
        bloc: _newsBloc,
        builder: (context, stream) {
          var repository = stream.repository as ServerRSSRepository;
          if (repository == null) {
            return Center(child: CircularProgressIndicator());
          }
          return FutureBuilder(
            future: repository.getItems(),
            builder: (BuildContext context, AsyncSnapshot<List<RssItem>> snapshot) {
              if (snapshot.hasData) {
                var widgets = <Widget>[];
                snapshot.data.forEach((data) {
                  if (snapshot.data.indexOf(data) <= 4) {
                    widgets.add(getCard(context, data));
                  }
                });
                return Column(children: widgets);
              }
              return Center(child: CircularProgressIndicator());
            }
          );
        }
    );
  }
}