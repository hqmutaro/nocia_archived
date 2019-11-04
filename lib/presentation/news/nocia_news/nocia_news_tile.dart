import 'package:flutter/material.dart';
import 'package:nocia/presentation/news/nocia_news/nocia_news_view.dart';

Card getCard(BuildContext context, Map<dynamic, dynamic> data) {
  return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.black26))),
                child: Icon(Icons.note, color: Colors.white),
              ),
              title: DefaultTextStyle(
                  style:  TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  child: Padding(
                    child: Text(data["title"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    padding: EdgeInsets.only(top: 10.0),
                  )
              ),
              subtitle: DefaultTextStyle(
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                child: Padding(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.timelapse, color: Colors.yellowAccent),
                      SizedBox(width: 5),
                      Text(data["date"], style: TextStyle(color: Colors.white))
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NociaNewsView(news: data)));
              },
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white)
          )
      )
  );
}