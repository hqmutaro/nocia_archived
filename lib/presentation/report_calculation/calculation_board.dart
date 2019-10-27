import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:nocia/presentation/nocia.dart';

class CalculationBoard extends StatefulWidget {

  @override
  _CalculationBoard createState() => _CalculationBoard();
}

class _CalculationBoard extends State<CalculationBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nocia.getAppBar("届作成"),
      body: Column(
        children: <Widget>[
        ],
      )
    );
  }

}