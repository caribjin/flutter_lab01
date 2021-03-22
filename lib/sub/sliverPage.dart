import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  Widget customCard(String text) {
    return Card(
      child: Container(
        height: 120,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }

  Widget customSLiverPersistentHeader(String text) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _HeaderDelegate(
        minHeight: 50,
        maxHeight: 150,
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 30),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver Example'),
              // centerTitle: true,
              background: Image.asset('repo/images/sunny.png', scale: 2),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            pinned: true,
          ),
          customSLiverPersistentHeader('리스트 숫자'),
          SliverList(
            delegate: SliverChildListDelegate([
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
            ]),
          ),
          customSLiverPersistentHeader('그리드 숫자'),
          SliverGrid(
            delegate: SliverChildListDelegate([
              customCard('1'),
              customCard('2'),
              customCard('3'),
              customCard('4'),
              customCard('5'),
              customCard('6'),
              customCard('7'),
              customCard('8'),
            ]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
          customSLiverPersistentHeader('생성된 숫자'),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                child: customCard('List Count $index'),
              );
            }, childCount: 10),
          ),
        ],
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      child: child,
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
