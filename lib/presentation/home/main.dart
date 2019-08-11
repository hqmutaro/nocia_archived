import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text(
              "Nocia",
              style: TextStyle(color: Colors.white)
          )
      ),
      body: Container(
        child: Text("hello"),
      ),
    );
  }
}