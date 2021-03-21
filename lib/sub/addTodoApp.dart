import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class AddTodoApp extends StatefulWidget {
  Future<Database> db;
  AddTodoApp(this.db);

  @override
  _AddTodoAppState createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    titleController = new TextEditingController();
    contentController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo 추가')),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: '제목'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: '할일'),
                ),
              ),
              RaisedButton(
                child: Text('저장하기'),
                onPressed: () {
                  Todo todo = Todo(
                    title: titleController.value.text.trim(),
                    content: contentController.value.text.trim(),
                    active: true,
                  );

                  Navigator.of(context).pop(todo);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
