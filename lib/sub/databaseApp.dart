import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'todo.dart';

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  const DatabaseApp(this.db);

  @override
  _DatabaseAppState createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);

    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id = ?', whereArgs: [todo.id]);

    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']
      );
    });
  }

  void _allUpdate() async {
    final database = await widget.db;
    await database.rawUpdate('UPDATE todos SET active=1 WHERE active=0');
    setState(() {
      todoList = getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
        actions: [
          FlatButton(
            child: Text(
              '완료한 일',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await Navigator.of(context).pushNamed('/clear');
              setState(() {
                todoList = getTodos();
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Todo todo = snapshot.data[index];

                          return ListTile(
                            title: Text(
                              todo.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Container(
                              child: Column(
                                children: [
                                  Text(todo.content),
                                  Text('체크: ${todo.active.toString()}'),
                                  Container(
                                    height: 1,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              TextEditingController controller = TextEditingController(text: todo.content);

                              Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: TextField(
                                      controller: controller,
                                      keyboardType: TextInputType.text,
                                    ),
                                    actions: [
                                      FlatButton(
                                        child: Text('예'),
                                        onPressed: () {
                                          setState(() {
                                            todo.active ? todo.active = false : todo.active = true;
                                            todo.content = controller.value.text.trim();
                                          });
                                          Navigator.of(context).pop(todo);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('아니오'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                }
                              );

                              if (result != null) {
                                _updateTodo(result);
                              }
                            },
                            onLongPress: () async {
                              Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: Text('${todo.content}를 삭제하시겠습니까?'),
                                    actions: [
                                      FlatButton(
                                        child: Text('예'),
                                        onPressed: () {
                                          Navigator.of(context).pop(todo);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('아니오'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                }
                              );

                              if (result != null) {
                                _deleteTodo(result);
                              }
                            },
                          );
                        }
                    );
                  } else {
                    return Text('No data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo);
              }
            },
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.update),
            onPressed: () async {
              _allUpdate();
            },
            heroTag: null,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}

