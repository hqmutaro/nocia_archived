import 'package:flutter/material.dart';
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
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _page,
            onTap: onTapBottomNavigation,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  title: Text("ニュース")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart),
                  title: Text("時間割")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.keyboard),
                  title: Text("届作成")
              ),
            ]
        ),
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