import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mathgames/pages/homepage.dart';
import 'package:mathgames/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  Admob.initialize('ca-app-pub-4117461851871825~8533296335');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => MathProvider(),
      child: MaterialApp(
        home: HomePage(),
        title: 'Math Games',
      ),
    );
  }
}