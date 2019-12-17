import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/infrastructure/repository/firebase_news_repository.dart';
import 'package:nocia/presentation/news/bloc.dart';
import 'package:nocia/presentation/news/nocia_news/nocia_news_tile.dart';

class NociaNewsBuilder extends StatelessWidget {

  NociaNewsBuilder();

  @override
  Widget build(BuildContext context) {
    final _newsBloc = BlocProvider.of<NewsBloc>(context);
    _newsBloc.add(UpdateNociaNews());
    return BlocBuilder<NewsBloc, NewsStream>(
      bloc: _newsBloc,
      builder: (context, stream) {
        var repository = stream.repository as FirebaseNewsRepository;
        if (repository == null) {
          return Center(child: CircularProgressIndicator());
        }
        return FutureBuilder<List<dynamic>>(
          future: repository.getNews(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var widgets = <Widget>[];
            snapshot.data.forEach((data) {
              if (!(snapshot.data.indexOf(data) >= 5)) {
                widgets.add(getCard(context, data));
              }
            });
            return Column(children: widgets);
          }
        );
      }
    );
  }
}