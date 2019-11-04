import 'package:nocia/domain/repository/repository.dart';
import 'package:nocia/domain/repository/rss_repository.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;

class ServerRSSRepository extends RSSRepository implements Repository {
  final String url = "http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%B3%D8%B9%BB%A4%CE%B3%E8%C6%B0";

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
  Future<List<RssItem>> getItems() async{
    var feed = await getFeed(url);
    return feed.items;
  }
}