import 'package:flutter/material.dart';
import './sub/firstPage.dart';
import './sub/secondPage.dart';
import './sub/animalItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyAppHome());
  }
}

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> with SingleTickerProviderStateMixin {
  TabController controller;
  List<Animal> animalList = [];

  @override
  void initState() {
    super.initState();

    controller = TabController(
        length: 2,
        vsync: this
    );

    initAnimals();
  }

  void initAnimals() {
    animalList.add(Animal(animalName: '벌', kind: '곤충', imagePath: 'lib/images/pic0.jpg'));
    animalList.add(Animal(animalName: '고양이', kind: '포유류', imagePath: 'lib/images/pic1.jpg'));
    animalList.add(Animal(animalName: '젖소', kind: '포유류', imagePath: 'lib/images/pic2.jpg'));
    animalList.add(Animal(animalName: '강아지', kind: '포유류', imagePath: 'lib/images/pic3.jpg'));
    animalList.add(Animal(animalName: '여우', kind: '포유류', imagePath: 'lib/images/pic4.jpg'));
    animalList.add(Animal(animalName: '원숭이', kind: '영장류', imagePath: 'lib/images/pic5.jpg'));
    animalList.add(Animal(animalName: '돼지', kind: '포유류', imagePath: 'lib/images/pic6.jpg'));
    animalList.add(Animal(animalName: '늑대', kind: '포유류', imagePath: 'lib/images/pic7.jpg'));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          FirstApp(list: animalList),
          SecondApp(list: animalList),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: controller,
        tabs: [
          Tab(
            icon: Icon(
              Icons.looks_one,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
