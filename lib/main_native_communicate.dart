import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:flutter/services.dart';
import 'sub/sendDataExample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

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
        navigatorObservers: <NavigatorObserver>[observer],
        home: NativeApp(analytics: analytics, observer: observer),
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
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  NativeApp({Key key, this.analytics, this.observer}) : super(key: key);

  @override
  _NativeAppState createState() => _NativeAppState(analytics, observer);
}

class _NativeAppState extends State<NativeApp> {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  _NativeAppState(this.analytics, this.observer);

  static const platform = const MethodChannel('com.flutter.dev/info');
  static const platform3 = const MethodChannel('com.flutter.dev/dialog');

  String _deviceInfo = 'Unknown info';
  String _message = '';

  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent(String type) async {
    await analytics.logEvent(
      name: 'flutter_event',
      parameters: <String, dynamic> {
        'string': type,
        'int': 100,
      }
    );

    setMessage('Analytics event 보내기 성공');
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;

    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device Info: $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info: `${e.message}`.';
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _showDialog() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch (e) {
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
              _sendAnalyticsEvent('deviceInfo');
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
              _sendAnalyticsEvent('encrypto');
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
              _sendAnalyticsEvent('dialog');
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
