import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nocia/application/user/user_bloc.dart';
import 'package:nocia/domain/service/google_auth.dart';
import 'package:nocia/infrastructure/repository/firebase_user_info_repository.dart';
import 'package:nocia/infrastructure/repository/user_repository.dart';
import 'package:nocia/infrastructure/service/firebase_auth.dart';
import 'package:nocia/infrastructure/service/service_google_auth.dart';
import 'package:nocia/presentation/introduction/intro_screen.dart';
import 'package:nocia/presentation/login/login_screen.dart';
import 'package:nocia/presentation/news/main.dart';
import 'package:nocia/presentation/home/home.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var auth = UserRepository();
    return FutureBuilder(
      future: auth.isAuth(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: auth.getUser(),
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot2) {
              return SplashScreen(
                  seconds: 0,
                  navigateAfterSeconds: snapshot.data ?
                  BlocProvider(
                    builder: (BuildContext context) => UserBloc(),
                    child: Home(),
                  ) : IntroScreen(),
                  title: Text("Nocia"),
                  backgroundColor: Colors.white,
                  loaderColor: Colors.white
              );
            },
          );
        }
        return Container();
      },
    );
  }
}