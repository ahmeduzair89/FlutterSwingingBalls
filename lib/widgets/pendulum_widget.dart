import 'package:flutter/material.dart';

class PendulumWidget extends StatelessWidget {
  String ballColor;
  PendulumWidget({super.key, this.ballColor = 'black'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 2,
          height: 300,
          color: Colors.black.withOpacity(0.5),
        ),
        Container(
          width: 45,
          height: 45,
          padding: EdgeInsets.zero,
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(2, 5),
              ),
            ],
          ),
          child: Image.asset(
            "assets/images/${ballColor}_ball.png",
          ),
        ),
      ],
    );
  }
}
