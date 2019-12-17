import 'package:flutter/material.dart';

enum Theme {
  LIGHT,
  DARK
}

class NociaTheme extends StatelessWidget {

  final String title;
  final Theme theme;
  final Widget home;

  const NociaTheme({
    Key key,
    @required this.title,
    @required this.theme,
    @required this.home,
  }):
      assert(title != null),
      assert(theme != null),
      assert(home != null),
      super(key: key);

  get darkTextTheme => TextTheme(
    body1: TextStyle(color: Colors.white),
    body2: TextStyle(color: Colors.white),
    title: TextStyle(color: Colors.white),
    subhead: TextStyle(color: Colors.white),
    headline: TextStyle(color: Colors.white)
  );

  get lightTextTheme => TextTheme(
    body1: TextStyle(color: Colors.black),
    body2: TextStyle(color: Colors.black),
    title: TextStyle(color: Colors.black),
    subhead: TextStyle(color: Colors.black),
    headline: TextStyle(color: Colors.black)
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
          canvasColor: Colors.transparent,
        textTheme: this.theme == Theme.DARK ? darkTextTheme : lightTextTheme,
        primaryColor: this.theme == Theme.DARK ? darkTheme : lightTheme,
        bottomAppBarColor: this.theme == Theme.DARK ? darkTheme : lightTheme,
        backgroundColor: this.theme == Theme.DARK ? darkTheme : lightTheme,
        appBarTheme: AppBarTheme(
          color: this.theme == Theme.DARK ? darkTheme : lightTheme
        ),
        cardColor: this.theme == Theme.DARK ? usuidark : lightTheme,
        dialogTheme: DialogTheme(
          backgroundColor: this.theme == Theme.DARK ? usuidark : lightTheme,
          titleTextStyle: TextStyle(
            color: this.theme == Theme.DARK ? Colors.white : Colors.black
          ),
        ),
        scaffoldBackgroundColor: this.theme == Theme.DARK ? darkTheme : lightTheme,
        buttonColor: this.theme == Theme.DARK ? usuidark : lightTheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: this.theme == Theme.DARK ? usuidark : lightTheme)
      ),
      home: this.home
    );
  }

  Color get usuidark => Color.fromRGBO(64, 75, 96, .9);

  Color get darkTheme => Color.fromRGBO(58, 66, 86, 1.0);

  Color get lightTheme => Colors.white;

  //Color get lightTheme => const Color(0xFFf58447);
}