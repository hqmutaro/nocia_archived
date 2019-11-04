import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class WaveClipperHeader extends StatelessWidget {

  final String message;

  const WaveClipperHeader({@required this.message}): assert(message != null);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(reverse: true),
      child: Container(
          height: 100,
          width: 400,
          color: const Color.fromRGBO(64, 75, 96, .9),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Text(
                this.message,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )
            )
          )
      )
    );
  }
}