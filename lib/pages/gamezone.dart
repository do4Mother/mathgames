import 'package:flutter/material.dart';
import 'package:mathgames/components/questiongame.dart';
import 'package:mathgames/components/timergame.dart';
import 'package:mathgames/model/math_model.dart';
import 'package:mathgames/provider/timeprovider.dart';
import 'package:provider/provider.dart';

class GameZone extends StatelessWidget {
  final String assets;
  GameZone({
    @required this.assets,
    Key key
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => TimeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Game Zone', style: TextStyle(
            fontFamily: 'letters',
            fontSize: 30,
            fontWeight: FontWeight.w600
          ),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
          elevation: 0.0,
          backgroundColor: Color(0xffFF0099),
        ),
        body: GameZoneBody(assets: assets),
      ),
    );
  }
}

class GameZoneBody extends StatefulWidget {
  final String assets;
  GameZoneBody({
    @required this.assets,
    Key key
  }) : super (key : key);

  @override
  _GameZoneBodyState createState() => _GameZoneBodyState();
}

class _GameZoneBodyState extends State<GameZoneBody> {
  bool takemeback = false;

  void _showdialog(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          content: Text("Sorry, if you return to the start page, the math test practice game cannot be resumed.\n\nAre you sure ?"),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.green,
              child: Text('No', style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              color: Colors.red,
              child: Text('Yes', style: TextStyle(color: Colors.white)),
              onPressed: (){
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            )
          ],
        );
      }
    );
  }

  Future<bool> _onwillpop() {
    _showdialog();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillpop,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFF0099),
              Color(0xff493240)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.0,
              0.9
            ]
          )
        ),
        padding: EdgeInsets.all(18),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TimerGame(),
                Consumer<TimeProvider>(
                  builder: (_, val, child){
                    return Text('${val.page + 1} / ${val.totalpage}', style: TextStyle(color: Colors.white),);
                  },
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: FutureBuilder<List<Data>>(
                future: Provider.of<TimeProvider>(context, listen: false).loadData(context, widget.assets),
                builder: (context, snapshot){
                  if(snapshot.hasData) {
                    return Question();
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
