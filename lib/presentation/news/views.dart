import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:intl/intl.dart';
import 'news_view.dart';
import 'package:http/http.dart' as http;

class Views extends StatelessWidget {

  Views();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getItems(),
      builder: (BuildContext context, AsyncSnapshot<List<RssItem>> snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data.map((item) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.white
                        ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5, left: 5),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                              Text(formatDate(item))
                            ],
                          )
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewsViews(item: item))),
                    )
                );
              }).toList()
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<RssItem>> getItems() async{
    var feed = await getFeed("http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%B3%D8%B9%BB%A4%CE%B3%E8%C6%B0");
    return feed.items;
  }

  Future<RssFeed> getFeed(String url) async{
    try {
      var response = await http.read(url);
      return RssFeed.parse(response);
    }
    catch (e) {
      print(e);
      return getFeed(url);
    }
  }

  String formatDate(RssItem item) {
    var format = DateFormat("EEE, d MMM yyyy HH:mm:ss Z").parse(item.pubDate);
    return format.year.toString() + "年" + format.month.toString() + "月" + format.day.toString() + "日";
  }
}