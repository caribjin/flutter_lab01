import 'package:flutter/material.dart';
import './animalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal> list;

  SecondApp({Key key, this.list}) : super(key: key);

  @override
  _SecondAppState createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int _radioValue = 0;
  bool flyExist = false;
  String _imagePath;

  void _radioChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  String getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return '양서류';
      case 1:
        return '파충류';
      case 2:
        return '포유류';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _radioChange,
                  ),
                  Text('양서류'),
                  Radio(
                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _radioChange,
                  ),
                  Text('파충류'),
                  Radio(
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: _radioChange,
                  ),
                  Text('포유류'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('날 수 있나요?'),
                  Checkbox(
                    value: flyExist,
                    onChanged: (check) {
                      setState(() {
                        flyExist = check;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic10.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic10.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic11.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic11.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic12.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic12.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic13.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic13.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic14.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic14.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic15.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic15.jpg',
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'lib/images/pic16.jpg',
                        width: 80,
                      ),
                      onTap: () => _imagePath = 'lib/images/pic16.jpg',
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  '동물 추가하기',
                ),
                onPressed: () {
                  var animal = Animal(
                    animalName: nameController.value.text,
                    kind: getKind(_radioValue),
                    flyExist: flyExist,
                    imagePath: _imagePath,
                  );

                  AlertDialog dialog = AlertDialog(
                    title: Text('동물 추가하기'),
                    content: Text(
                      '이 동물은 ${animal.animalName} 입니다.'
                      '동물의 종류는 ${animal.kind}입니다.\n이 동물을 추가하시겠습니까?',
                      style: TextStyle(fontSize: 30),
                    ),
                    actions: [
                      RaisedButton(
                        child: Text('예'),
                        onPressed: () {
                          widget.list.add(animal);
                          Navigator.of(context).pop();
                        },
                      ),
                      RaisedButton(
                        child: Text('아니오'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
