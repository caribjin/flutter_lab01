import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Second Main',
        ),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('첫 번째 페이지로 돌아가기'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
