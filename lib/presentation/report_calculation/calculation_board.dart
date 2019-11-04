import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:nocia/presentation/nocia_theme.dart';

class CalculationBoard extends StatefulWidget {

  @override
  _CalculationBoard createState() => _CalculationBoard();
}

class _CalculationBoard extends State<CalculationBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("届作成"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      )
    );
  }

}