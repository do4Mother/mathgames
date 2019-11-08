import 'package:flutter/material.dart';
import 'package:mathgames/provider/provider.dart';
import 'package:mathgames/provider/timeprovider.dart';
import 'package:provider/provider.dart';

class Question extends StatelessWidget {
  const Question({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("question on run!");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          height: MediaQuery.of(context).size.height / 7,
          child: Center(
            child: Consumer<TimeProvider>(
              builder: (_, val, child){
                return Text(val.data[val.page].soal + ' = ?', style: TextStyle(
                  fontSize: 38,
                ),);
              },
            )
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Consumer<TimeProvider>(
          builder: (_, val, child) => Answer(a: val.data[val.page].pilihan[0], b: val.data[val.page].pilihan[1]),
        ),
        SizedBox(
          height: 20,
        ),
        Consumer<TimeProvider>(
          builder: (_, val, child) => Answer(a: val.data[val.page].pilihan[2], b: val.data[val.page].pilihan[3]),
        ),
      ],
    );
  }
}

class Answer extends StatelessWidget {
  final int a, b;
  const Answer({
    @required this.a, @required this.b,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              height: MediaQuery.of(context).size.height / 6,
              child: Center(
                child: Text(a.toString(), style: TextStyle(
                  fontSize: 38,
                ),)
              ),
            ),
            onTap: (){
              var math = Provider.of<MathProvider>(context, listen: false);
              var timer = Provider.of<TimeProvider>(context, listen: false);
              // check answer

              if (timer.data[timer.page].jawab == a) {
                math.addAnswer('yes');
              } else {
                math.addAnswer('no');
              }

              timer.nextpage(context);

              // resetTime
              timer.timegame = 30;
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 10,
        ),
        Expanded(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              height: MediaQuery.of(context).size.height / 6,
              child: Center(
                child: Text(b.toString(), style: TextStyle(
                  fontSize: 38,
                ),)
              ),
            ),
            onTap: (){
              var math = Provider.of<MathProvider>(context, listen: false);
              var timer = Provider.of<TimeProvider>(context, listen: false);

              // check answer
              if (timer.data[timer.page].jawab == b) {
                math.addAnswer('yes');
              } else {
                math.addAnswer('no');
              }

              timer.nextpage(context);

              // resetTime
              timer.timegame = 30;
            },
          ),
        )
      ],
    );
  }
}