import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:nocia/presentation/login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreen createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: [
        Slide(
          title: "ここにタイトル",
          description:
          "せつめいをいれろ\nせつめいをいれろ",
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Raleway'),
          backgroundColor: Color.fromRGBO(64, 75, 96, .9),
          marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0)
        ),
        Slide(
          title: "ここにタイトル",
          description:
          "せつめいをいれろ\nせつめいをいれろ",
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Raleway'),
          marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
          backgroundColor: Color.fromRGBO(64, 75, 96, .9)
        ),
        Slide(
            title: "ここにタイトル",
            description:
            "せつめいをいれろ\nせつめいをいれろ",
            styleDescription: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Raleway'),
            marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
            backgroundColor: Color.fromRGBO(64, 75, 96, .9)
        ),
        Slide(
            title: "ここにタイトル",
            description:
            "せつめいをいれろ\nせつめいをいれろ",
            styleDescription: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Raleway'),
            marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
            backgroundColor: Color.fromRGBO(64, 75, 96, .9)
        )
      ],
      nameNextBtn: "NEXT",
      nameDoneBtn: "LOGIN",
      namePrevBtn: "PREVIOUS",
      nameSkipBtn: "SKIP",
      onDonePress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    );
  }
}