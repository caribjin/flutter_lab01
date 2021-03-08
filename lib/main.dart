import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  Widget _buildImageColumn() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        children: [
          _buildImageRow(1),
          _buildImageRow(3),
        ],
      ),
    );
  }

  Widget _buildImageRow(int imageIndex) {
    return Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
  }

  Widget _buildDecoratedImage(int imageIndex) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 10,
            color: Colors.black38,
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('lib/images/pic$imageIndex.jpg'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation Menu',
          onPressed: null,
        ),
        title: Text('Exaple Title'),
      ),
      body: Center(
        child: _buildImageColumn(),
      ),
    );
  }
}
