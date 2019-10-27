import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:nocia/domain/date_calculation.dart';
import 'package:nocia/presentation/app.dart';
import 'package:html/dom.dart' as Dom;
import "dart:convert";

import 'package:webfeed/domain/rss_feed.dart';

void main() async{
  runApp(App());
  var url = "http://www.okinawa-ct.ac.jp/rss/RssFeed.jsp?select=%B3%D8%B9%BB%A4%CE%B3%E8%C6%B0";
}

Future<RssFeed> getFeed(String url) async{
  var sXml = await http.read(url);
  return RssFeed.parse(sXml);
}