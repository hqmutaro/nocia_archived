import 'package:flutter/material.dart';
import 'package:nocia/presentation/splash.dart';
import 'package:nocia/presentation/nocia.dart';

class App extends StatelessWidget {

  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Nocia(
      title: "Nocia",
      home: Splash(),
    );
  }
}