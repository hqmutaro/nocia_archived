import 'package:flutter/material.dart';
import 'package:nocia/presentation/nocia_theme.dart';
import 'package:nocia/presentation/report_calculation/calculation_board.dart';
import 'package:nocia/presentation/time_table/display.dart';
import 'news/main.dart';

class Test extends StatefulWidget {

  const Test({Key key}) : super(key: key);

  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        bottomNavigationBar: makeBottom,
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: [
            News(),
            Display(),
            CalculationBoard()
          ],
        ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
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