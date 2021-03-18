import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubDetail extends StatefulWidget {
  @override
  _SubDetailState createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _setData(List<String> list) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('todos', todoList);
  }

  void _loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      List<String> list = pref.getStringList('todos');

      if (list == null) {
        todoList = ['Todo 1', 'Todo 2'];
      } else {
        todoList = list;
      }
    });
  }

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');

    setState(() {
      todoList.add(result);
    });

    _setData(todoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail Example')
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              child: Text(
                todoList[index],
                style: TextStyle(fontSize: 30),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/third', arguments: todoList[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addNavigation(context);
        },
      ),
    );
  }
}


