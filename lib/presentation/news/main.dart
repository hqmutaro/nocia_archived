import 'package:flutter/material.dart';
import 'package:nocia/presentation/nocia.dart';


class News extends StatefulWidget {

  const News({Key key}) : super(key: key);

  @override
  _News createState() => _News();
}

class _News extends State<News> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nocia.getAppBar("ニュース"),
      drawer: Nocia.getDrawer(),
      backgroundColor: Color(0xFFEFEFEF),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 0),
              child: Text(
                  "新着情報",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  )
              )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
                "学校の活動",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                )
            )
          )
        ],
      )
    );
  }
}