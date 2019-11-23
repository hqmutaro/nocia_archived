import 'package:flutter/material.dart';

class DayCell extends StatelessWidget {
  final String day;

  const DayCell(this.day): assert(day != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(day, style: TextStyle(color: Colors.black))
      ),
      width: 30,
      height: 40
    );
  }
}