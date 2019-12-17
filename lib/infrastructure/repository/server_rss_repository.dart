import 'dart:math';

import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/domain/repository/rss_repository.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;

class ServerRSSRepository extends RSSRepository implements Repository {
  final String schoolInfo = "http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%B3%D8%B9%BB%A4%CE%B3%E8%C6%B0";
  final String examInfo = "http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%BC%F5%B8%B3%A4%F2%A4%AA%B9%CD%A4%A8%A4%CE%CA%FD%A4%D8";
  final String toPerson = "http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%B3%D8%C0%B8%A1%A6%CA%DD%B8%EE%BC%D4%A4%CE%CA%FD%A4%D8";

  @override
  Future<RssFeed> getFeed(String url) async{
    try {
      var response = await http.read(url);
      return RssFeed.parse(response);
    }
    catch (e) {
      return getFeed(url);
    }
  }

  @override
  Future<List<RssItem>> getItems(NewsType type) async{
    var feed;
    switch (type) {
      case NewsType.ExamInfo:
        feed = await getFeed(examInfo);
        break;
      case NewsType.SchoolInfo:
        feed = await getFeed(schoolInfo);
        break;
      case NewsType.ToPerson:
        feed = await getFeed(toPerson);
        break;
      default:
        feed = await getFeed(schoolInfo);
        break;
    }
    return feed.items;
  }
}

enum NewsType {
  SchoolInfo,
  ExamInfo,
  ToPerson
}