import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';


class SchoolNewsView extends StatefulWidget {

  RssItem item;

  SchoolNewsView({@required this.item});

  @override
  _SchoolNewsView createState() => _SchoolNewsView();
}

class _SchoolNewsView extends State<SchoolNewsView> {

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
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
