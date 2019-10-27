import 'package:flutter/material.dart';
import 'package:nocia/presentation/news/views.dart';
import 'package:nocia/presentation/nocia.dart';
import 'package:nocia/presentation/report_calculation/calculation_board.dart';
import 'package:nocia/presentation/time_table/display.dart';
import 'package:nocia/presentation/news/news_view.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'package:webfeed/domain/rss_item.dart';
import 'package:intl/intl.dart';


class News extends StatefulWidget {

  const News({Key key}) : super(key: key);

  @override
  _News createState() => _News();
}

class _News extends State<News> {

  List<dynamic> iku = [""];

  List<RssItem> feeds;

  @override
  void initState() {
    super.initState();
    iku = [""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nocia.getAppBar("ニュース"),
      drawer: Nocia.getDrawer(),
      backgroundColor: Color(0xFFEFEFEF),
      body: Views()
    );
  }
  
  String formatDate(RssItem item) {
    var format = DateFormat("EEE, d MMM yyyy HH:mm:ss Z").parse(item.pubDate);
    return format.year.toString() + "年" + format.month.toString() + "月" + format.day.toString() + "日";
  }

  List<RssItem> getFeeds() => this.feeds;

  List<String> getMenu() {
    return <String>[
      "Sample1",
      "Sample2",
      "Sample3",
      "Sample4",
      "Sample5",
      "Sample6"
    ];
  }
}