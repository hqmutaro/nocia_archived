import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nocia/presentation/news/main.dart';
import 'package:nocia/presentation/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 0,
      navigateAfterSeconds: Test(),
      title: Text("Nocia"),
      backgroundColor: Colors.white,
      loaderColor: Colors.white
    );
  }
}