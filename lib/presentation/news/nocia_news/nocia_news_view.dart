import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NociaNewsView extends StatefulWidget {

  Map<dynamic, dynamic> news;

  NociaNewsView({@required this.news});

  @override
  _NociaNewsView createState() => _NociaNewsView();
}

class _NociaNewsView extends State<NociaNewsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.news["title"]),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                    widget.news["title"],
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1, left: 200),
                child: Text(
                    widget.news["date"],
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              MarkdownBody(data: widget.news["body"]),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 30),
                child: Text(
                    "著者" + widget.news["author"],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ],
          )
        )
    );
  }
}
