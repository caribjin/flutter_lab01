import 'package:flutter/material.dart';
import 'package:flutter_lab01/sub/thirdDetail.dart';
import './sub/subDetail.dart';
import './sub/secondDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second': (context) => SecondDetail(),
        '/third': (context) => ThirdDetail()
      },
    );
  }
}
