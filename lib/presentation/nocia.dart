import 'package:flutter/material.dart';

class Nocia extends StatelessWidget {

  final String title;
  final Widget home;

  const Nocia({
    Key key,
    @required this.title,
    @required this.home,
  }):
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

  static Color get themeColor => Color(0xFFeaadbd);

  static AppBar getAppBar(String title) {
    return AppBar(
      backgroundColor: themeColor,
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(Icons.settings),
        )
      ],
    );
  }

  static Drawer getDrawer() {
    return Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
              decoration: BoxDecoration(
                color: themeColor
              ), child: null,
            ),
            ListTile(
              title: Text('First Menu Item'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Second Menu Item'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('About'),
              onTap: () {},
            ),
          ],
        )
    );
  }
}