import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mathgames/pages/gamezone.dart';
import 'package:mathgames/provider/timeprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => TimeProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffFF0099),
          title: Text('Math Games', style: TextStyle(
            fontFamily: 'letters',
            fontSize: 30,
            fontWeight: FontWeight.w600
          ),),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.exclamationCircle),
            onPressed: (){
              launch('https://sites.google.com/view/mathgames-do4mother/beranda');
            },
          ),
        ),
        body: HomePageBody(),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
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
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: MediaQuery.of(context).size.height / 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MenuButton(text: 'Addition'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              MenuButton(text: 'Subtraction'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              MenuButton(text: 'Multiplication'),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              MenuButton(text: 'Division'),
            ],
          )
        ),
        Align(
          child: AdmobBanner(
            adUnitId: 'ca-app-pub-4117461851871825/1500984120',
            adSize: AdmobBannerSize.BANNER,
          ),
          alignment: Alignment.bottomCenter,
        )
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  const MenuButton({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      color: Colors.blue[50],
      child: Text(text, style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 18
      ),),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => GameZone(assets: text.toLowerCase()),
          settings: RouteSettings(name: 'gamezone')
        ));
      },
    );
  }
}