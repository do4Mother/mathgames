import 'package:flutter/material.dart';
import 'package:mathgames/provider/timeprovider.dart';
import 'package:provider/provider.dart';

class TimerGame extends StatelessWidget {
  const TimerGame({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 35,
            height: 35,
            color: Colors.white,
            child: Consumer<TimeProvider>(
              builder: (context, math, child) => Center(child: Text(math.timegame.toString())),
            )
          ),
        ),
      ],
    );
  }
}