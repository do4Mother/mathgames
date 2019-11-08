import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathgames/components/customalert.dart';
import 'package:mathgames/model/math_model.dart';
import 'package:mathgames/pages/success.dart';
import 'package:mathgames/provider/provider.dart';
import 'package:provider/provider.dart';

class TimeProvider extends ChangeNotifier {
  // timer section
  int _timegame = 30;
  Timer _timer;
  
  int _page = 0;
  int _totalpage = 0;

  int get page => _page;

  int get totalpage => _totalpage;

  set page(int newpage) {
    _page = newpage;
    notifyListeners();
  }

  set totalpage(int newtotal) {
    _totalpage = newtotal;
    notifyListeners();
  }

  void nextpage(BuildContext context) {
    if (page + 1 == totalpage) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => Success()
      ));
    } else {
      page = _page + 1;
    }
  }

  List<Data> _mathModel;

  List<Data> get data => _mathModel;

  set data (List<Data> newdata) {
    _mathModel = newdata.toList()
    ..shuffle();
    _mathModel = _mathModel..asMap()
    .forEach((i, data) => _mathModel[i].pilihan = data.pilihan.toList()..shuffle());
    notifyListeners();
  }
  
  Future<List<Data>> loadData(BuildContext context, String assets) async {
    var getdata = await DefaultAssetBundle.of(context).loadString("assets/$assets.json");
    data = MathModel.fromJson(jsonDecode(getdata)).data;
    totalpage = data.length;
    runtimer(context);
    return data;
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  int get timegame => _timegame;

  set timegame(int newtime) {
    _timegame = newtime;
    notifyListeners();
  }

  void runtimer(BuildContext context) {
    print('run timer called');
    if (_timegame > 0 && _timegame != 30) {
      print('timer on run!');
      return;
    } else if (_timegame == 0) {
      timegame = 30;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (_){
      timegame = _timegame - 1;
      if (_timegame == 0) {
        showAlert(context);
        _timer.cancel();
      }
    });
  }

  Future<bool> _onwillpop() {
    return Future.value(false);
  }

  void showAlert(BuildContext context) {
    Future.delayed(Duration(seconds: 5), (){
      Navigator.popUntil(context, ModalRoute.withName('gamezone'));
      Provider.of<MathProvider>(context, listen: false).addAnswer('timeout');
      nextpage(context);
      runtimer(context);
    });

    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: _onwillpop,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            content: CustomAlert(),
          ),
        );
      }
    );
  }
}