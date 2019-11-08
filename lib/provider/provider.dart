
import 'package:flutter/material.dart';

class MathProvider extends ChangeNotifier {
  List<String> _answerlist = new List();
  List<int> _scorelist = [0, 0, 0, 0];

  List<int> get scorelist => _scorelist;

  void addAnswer(String answer){
    _answerlist.add(answer);
  }

  void addScore(List<int> score){
    _scorelist = score;
    notifyListeners();
  }

  void getcalculation() {
    Future.delayed(Duration(microseconds: 500), () {
      int rightanswer = _answerlist.where((val) => val == 'yes').toList().length;
      int wronganswer = _answerlist.where((val) => val == 'no').toList().length;
      int noanswer = _answerlist.where((val) => val == 'timeout').toList().length;
      _answerlist = new List();
      int score = (rightanswer * 10) - (wronganswer * 2) - (noanswer * 5);
      _scorelist = [0, 0, 0, 0];
      addScore([score, rightanswer, wronganswer, noanswer]);
    });
  }

}