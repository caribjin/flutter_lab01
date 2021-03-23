import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataExample extends StatefulWidget {
  @override
  _SendDataExampleState createState() => _SendDataExampleState();
}

class _SendDataExampleState extends State<SendDataExample> {
  static const platform = const MethodChannel('com.flutter.dev/encrypto');

  TextEditingController controller = TextEditingController();
  String _changeText = 'Nothing';
  String _reChangeText = 'Nothing';

  Future<void> _encodeData(String text) async {
    final String result = await platform.invokeMethod('getEncrypto', text);
    setState(() {
      _changeText = result;
    });
  }

  Future<void> _decodeData(String text) async {
    print('before: $text');
    final String result = await platform.invokeMethod('getDecrypto', text);
    print('after: $result');
    setState(() {
      _reChangeText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Data Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                _changeText,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                _reChangeText,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Text('변환'),
            onPressed: () {
              _encodeData(controller.value.text.trim());
            },
            heroTag: 'encode',
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Text('복원'),
            onPressed: () {
              _decodeData(_changeText);
            },
            heroTag: 'decode',
          )
        ],
      ),
    );
  }
}
