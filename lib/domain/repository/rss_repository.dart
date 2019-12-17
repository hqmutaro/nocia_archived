import 'package:nocia/infrastructure/repository/server_rss_repository.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

abstract class RSSRepository {
  Future<List<RssItem>> getItems(NewsType type);
  Future<RssFeed> getFeed(String url);
}