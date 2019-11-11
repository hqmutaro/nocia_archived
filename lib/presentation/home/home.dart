import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/presentation/report_calculation/calculation_board.dart';
import 'package:nocia/presentation/timetable/display.dart';
import 'package:nocia/presentation/ui/drawer/nocia_drawer.dart';
import '../news/main.dart';

class Home extends StatefulWidget {

  final FirebaseUser user;
  const Home({this.user, Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  PageController _pageController;
  String title;
  List<String> titles = [
    "ニュース",
    "時間割",
    "届作成"
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    this.title = this.titles[0];
  }

  @override
  Widget build(BuildContext context) {
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {onTapBottomNavigation(0);},
            ),
            IconButton(
              icon: Icon(Icons.table_chart, color: Colors.white),
              onPressed: () {onTapBottomNavigation(1);},
            ),
            IconButton(
              icon: Icon(Icons.keyboard, color: Colors.white),
              onPressed: () {onTapBottomNavigation(2);},
            ),
          ],
        ),
      ),
    );
    var userRepository = UserRepository();
    return FutureBuilder(
        future: userRepository.getUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          var user = widget.user;
          if (user == null) {
            user = snapshot.data;
          }
          return Scaffold(
              backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              bottomNavigationBar: makeBottom,
              appBar: AppBar(
                title: Text(this.title),
                centerTitle: true,
                leading: Icon(Icons.menu),
              ),
              drawer: NociaDrawer(user: user),
              body: PageView(
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    News(),
                    Display(),
                    CalculationBoard()
                  ]
              )
          );
        }
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this.title = titles[page];
    });
  }

  void onTapBottomNavigation(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}