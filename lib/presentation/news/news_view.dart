import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nocia/presentation/nocia.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsViews extends StatefulWidget {

  RssItem item;

  NewsViews({@required this.item});

  @override
  _NewsViews createState() => _NewsViews();
}

class _NewsViews extends State<NewsViews> {

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        backgroundColor: Nocia.themeColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async{
              await _controller.reload();
            },
          ),
          IconButton(
            icon: Icon(Icons.add_comment),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(title: Text('webviewの上に表示'),);
              });
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: "http://www.okinawa-ct.ac.jp/sp/" + widget.item.link.substring(29),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      )
    );
  }
}
