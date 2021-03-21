import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './todo.dart';

class ClearListApp extends StatefulWidget {
  Future<Database> database;

  ClearListApp(this.database);

  @override
  _ClearListAppState createState() => _ClearListAppState();
}

class _ClearListAppState extends State<ClearListApp> {
  Future<List<Todo>> clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT title, content, id FROM todos WHERE active=1');

    return List.generate(maps.length, (i) {
      return Todo(
          title: maps[i]['title'],
          content: maps[i]['content'],
          id: maps[i]['id']);
    });
  }

  void _removeAllTodos() async {
    final Database database = await widget.database;
    database.rawQuery('DELETE FROM todos WHERE active=1');
    setState(() {
      clearList = getClearList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: clearList,
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
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  } else {
                    return Text('No data');
                  }
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('완료한 일 삭제'),
                content: Text('완료한 일을 모두 삭제할까요?'),
                actions: [
                  FlatButton(
                    child: Text('예'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }
                  ),
                  FlatButton(
                    child: Text('아니오'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }
                  ),
                ],
              );
            }
          );

          if (result) {
            _removeAllTodos();
          }
        }
      ),
    );
  }
}
