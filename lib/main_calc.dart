import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetAppState createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  String sum = '없음';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  String _buttonText = '';

  List<String> _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropdownMenuItem = [];

  String getCalc() {
    var result;
    double val1 = double.parse(value1.value.text);
    double val2 = double.parse(value2.value.text);

    switch (_buttonText) {
      case '더하기':
        result = val1 + val2;
        break;
      case '빼기':
        result = val1 - val2;
        break;
      case '곱하기':
        result = val1 * val2;
        break;
      case '나누기':
        result = val1 / val2;
        break;
      default:
        break;
    }

    return '$result';
  }

  @override
  void initState() {
    super.initState();

    for (var item in _buttonList) {
      _dropdownMenuItem.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }

    _buttonText = _dropdownMenuItem[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  '결과: $sum',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: value1,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: value2,
                  keyboardType: TextInputType.number,
                ),
              ),
              DropdownButton(
                items: _dropdownMenuItem,
                value: _buttonText,
                onChanged: (value) {
                  setState(() {
                    _buttonText = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      Text(
                        'Text',
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      sum = getCalc();
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
