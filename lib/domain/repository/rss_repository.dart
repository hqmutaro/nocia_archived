import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

abstract class RSSRepository {
  Future<List<RssItem>> getItems();
  Future<RssFeed> getFeed(String url);
}