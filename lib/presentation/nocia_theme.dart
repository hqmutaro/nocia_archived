import 'package:flutter/material.dart';

class NociaTheme extends StatelessWidget {

  final String title;
  final Widget home;

  const NociaTheme({
    Key key,
    @required this.title,
    @required this.home,
  }) :
      assert(title != null),
      assert(home != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(primaryColor: Colors.indigoAccent),
      home: this.home
    );
  }
}