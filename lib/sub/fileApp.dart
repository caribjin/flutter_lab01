import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'largeFileMain.dart';

class FileApp extends StatefulWidget {
  @override
  _FileAppState createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {
  int _count = 0;
  List<String> itemList = [];
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    readCountFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();

      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void writeCountFile() async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(_count.toString());
  }

  Future<List<String>> readListFile() async {
    List<String> itemList = [];
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool firstCheck = pref.getBool('first');
    var dir = await getApplicationDocumentsDirectory();
    var fileExist = await File(dir.path + '/fruit.txt').exists();

    if (firstCheck == null || !firstCheck || !fileExist) {
      pref.setBool('first', true);

      var assetFile = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsStringSync(assetFile);
      var array = assetFile.split('\n');

      for (var item in array) {
        print(item);
        itemList.add(item);
      }
    } else {
      var file = await File(dir.path + '/fruit.txt').readAsString();
      var array = file.split('\n');

      for (var item in array) {
        print(item);
        itemList.add(item);
      }
    }

    return itemList;
  }

  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '/fruit.txt').writeAsString(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Example'),
        actions: [
          FlatButton(
            child: Text(
              '로고 바꾸기',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LargeFileMain()));
            },
          ),
        ]
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Center(
                        child: Text(
                          itemList[index],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            itemList.add(controller.value.text);
          });
          writeFruit(controller.value.text);

        }
      ),
    );
  }
}
