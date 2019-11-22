import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/application/user/user_event.dart';
import 'package:nocia/application/user/user_state.dart';
import 'package:nocia/domain/user.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/presentation/report_calculation/calculation_board.dart';
import 'package:nocia/presentation/timetable/display.dart';
import 'package:nocia/presentation/ui/drawer/nocia_drawer.dart';
import '../news/main.dart';

class Home extends StatefulWidget {

  const Home({Key key}) : super(key: key);

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

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    this.title = this.titles[0];
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _buildDialog(context, message["notification"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _buildDialog(context, "onLaunch");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _buildDialog(context, "onResume");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("/topics/all");
  }

  // ダイアログを表示するメソッド
  void _buildDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: new Text("Message: $message", style: TextStyle(color: Colors.white),),
            actions: <Widget>[
              new FlatButton(
                child: const Text('CLOSE'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              new FlatButton(
                child: const Text('SHOW'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        }
    );
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
    var bloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
        print("state is $state");
          if (state is Initial) {
            bloc.add(RequestUser());
            return Container(child: Center(child: CircularProgressIndicator()), color: Colors.white,);
          }
          if (state is UserStream) {
            return Scaffold(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                bottomNavigationBar: makeBottom,
                appBar: AppBar(
                  title: Text(this.title),
                  centerTitle: true,
                ),
                drawer: NociaDrawer(user: state.user),
                body: PageView(
                    controller: _pageController,
                    onPageChanged: onPageChanged,
                    children: [
                      News(),
                      Display(user: state.user),
                      CalculationBoard()
                    ]
                )
            );
          }
          return Container();
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