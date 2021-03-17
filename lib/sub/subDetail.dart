import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  @override
  _SubDetailState createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Example')
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('두 번째 페이지로 이동'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/second');
            },
          ),
        ),
      ),
    );
  }
}

