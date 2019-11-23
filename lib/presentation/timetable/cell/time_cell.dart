import 'package:flutter/material.dart';

class TimeCell extends StatelessWidget {
  final String period;
  final String startTime;
  final String finishTime;

  const TimeCell(
    this.period,
    this.startTime,
    this.finishTime
  ):  assert(period != null),
      assert(startTime != null),
      assert(finishTime != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  period,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6592C6)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  startTime,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  finishTime,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}