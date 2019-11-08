import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathgames/provider/provider.dart';
import 'package:provider/provider.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  AdmobInterstitial rewardAd = AdmobInterstitial(
    adUnitId: 'ca-app-pub-4117461851871825/4906466302',
  );

  void _rewardads() async {
    rewardAd.load();

    // Check if the ad is loaded and then show it
    if (await rewardAd.isLoaded) {
      rewardAd.show();
    }
  }

  @override
  void initState() {
    super.initState();
    _rewardads();
  }

  @override
  void dispose() {
    super.dispose();
    rewardAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xffFF0099),
      ),
      body: SuccessBody(),
    );
  }
}

class SuccessBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<MathProvider>(context, listen: false).getcalculation();
    return SingleChildScrollView(
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
              0.2,
              0.8
            ]
          )
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('The Math Test Has Finished', style: TextStyle(
              fontSize: 28 * MediaQuery.of(context).textScaleFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ), textAlign: TextAlign.center,),
            SizedBox(
              height: MediaQuery.of(context).size.height/30,
            ),
            ShaderMask(
              child: Icon(FontAwesomeIcons.award, size: 180),
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: [
                    Color(0xffDCA640),
                    Color(0xffE4C74D)
                  ],
                ).createShader(rect);
              },
              blendMode: BlendMode.srcATop,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/14,
            ),
            Text('Score', style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
            SizedBox(
              height: MediaQuery.of(context).size.height/120,
            ),
            Consumer<MathProvider>(
              builder: (_, math, child){
                return Text(math.scorelist[0].toString(), style: TextStyle(
                  fontSize: MediaQuery.of(context).textScaleFactor * 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[200]
                ),);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Consumer<MathProvider>(
                  builder: (_, math, child){
                    return Stats(score: math.scorelist[1], text: 'Right',);
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Consumer<MathProvider>(
                  builder: (_, math, child){
                    return Stats(score: math.scorelist[2], text: 'Wrong',);
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                Consumer<MathProvider>(
                  builder: (_, math, child){
                    return Stats(score: math.scorelist[3], text: 'Timeout',);
                  },
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Text('if you are right then the score increases by 10, if wrong then the score is reduced by 2, if it does not answer and runs out of time the score is reduced by 5',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}

class Stats extends StatelessWidget {
  final String text;
  final int score;
  const Stats({
    @required this.text, @required this.score,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(text, style: TextStyle(
          fontSize: MediaQuery.of(context).textScaleFactor * 18,
          color: Colors.white
        ),),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
        Text(score.toString(), style: TextStyle(
          fontSize: MediaQuery.of(context).textScaleFactor * 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),)
      ],
    );
  }
}