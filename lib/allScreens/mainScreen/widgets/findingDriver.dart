import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
class FindingDriver extends StatelessWidget {
  final double defaultSize;
  FindingDriver({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultSize * 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 2.5),
          topRight: Radius.circular(defaultSize * 2.5),
        ),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            spreadRadius: defaultSize * .1,
            blurRadius: defaultSize * 1.2,
            color: Colors.black54,
            offset: Offset(defaultSize * .07, defaultSize * .07),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: Container(),),
          DefaultTextStyle(
            style: TextStyle(
              fontSize: defaultSize * 3,
              fontFamily: "Brand Bold",
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Requesting Ride . . .'),
                WavyAnimatedText('Please Wait . . .'),
                WavyAnimatedText('Finding a driver'),
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ],
      ),
    );
  }
}
