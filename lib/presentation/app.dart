import 'package:flutter/material.dart';
import 'package:nocia/presentation/nocia_theme.dart';
import 'package:nocia/presentation/home/main.dart';

class App extends StatelessWidget {

  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NociaTheme(
      title: "Nocia",
      home: Home(),
    );
  }
}