import 'dart:math';

import 'package:flutter/material.dart';

class SecondPageGraph extends StatefulWidget {
  @override
  _SecondPageGraphState createState() => _SecondPageGraphState();
}

class _SecondPageGraphState extends State<SecondPageGraph> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _rotateAnimation;
  Animation _scaleAnimation;
  Animation _transAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: Duration(seconds: 5), vsync: this);
    _rotateAnimation = Tween<double>(begin: 0, end: pi * 10).animate(_animationController);
    _scaleAnimation = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _transAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(200, 200)).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (BuildContext context, Widget widget) {
                  return Transform.translate(
                    offset: _transAnimation.value,
                    child: Transform.rotate(
                      angle: _rotateAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: widget,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'detail',
                  child: Icon(Icons.cake, size: 300),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _animationController.forward();
                },
                child: Text('로테이션 시작하기'),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
