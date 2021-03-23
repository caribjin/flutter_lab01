import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'sub/sendDataExample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home: CupertinoNativeApp(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NativeApp(),
      );
    }
  }
}

class CupertinoNativeApp extends StatefulWidget {
  @override
  _CupertinoNativeAppState createState() => _CupertinoNativeAppState();
}

class _CupertinoNativeAppState extends State<CupertinoNativeApp> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class NativeApp extends StatefulWidget {
  @override
  _NativeAppState createState() => _NativeAppState();
}

class _NativeAppState extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  static const platform3 = const MethodChannel('com.flutter.dev/dialog');

  String _deviceInfo = 'Unknown info';

  Future<void> _getDeviceInfo() async {
    String deviceInfo;

    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device Info: $result';
    } on PlatformException catch(e) {
      deviceInfo = 'Failed to get Device info: `${e.message}`.';
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _showDialog() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch(e) {
      print('ERROR: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native communicate demo'),
      ),
      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            onPressed: () {
              _getDeviceInfo();
            },
            child: Text('정보'),
            heroTag: 'deviceInfo',
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendDataExample()));
            },
            child: Text('변환'),
            heroTag: 'encrypto',
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _showDialog();
            },
            child: Text('알림'),
            heroTag: 'dialog',
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
