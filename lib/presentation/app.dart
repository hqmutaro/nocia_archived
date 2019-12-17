import 'package:flutter/material.dart';
import 'package:nocia/presentation/splash.dart';
import 'package:nocia/presentation/nocia_theme.dart' as theme;

class App extends StatelessWidget {

  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return theme.NociaTheme(
      title: "Nocia",
      home: Splash(),
      theme: theme.Theme.DARK,
    );
  }
}