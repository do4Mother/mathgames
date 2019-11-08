import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset('assets/img/sad-icon.jpg', width: MediaQuery.of(context).size.width / 2.5,),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 16,
          ),
          Text('Sorry time has run out. The next question will be starting...')
        ],
      ),
    );
  }
}