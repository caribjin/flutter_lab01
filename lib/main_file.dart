import 'package:flutter/material.dart';
import './sub/fileApp.dart';
import './sub/introPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // home: FileApp()
      home: IntroPage(),
    );
  }
}
