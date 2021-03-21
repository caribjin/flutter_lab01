import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'fileApp.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Widget logo = Icon(
    Icons.info,
    size: 50,
  );

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/myimage.jpg').exists();

    if (fileExist) {
      setState(() {
        logo = Image.file(
          File(dir.path + '/myimage.jpg'),
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              logo,
              RaisedButton(
                child: Text('다음으로 가기'),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FileApp()));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}


