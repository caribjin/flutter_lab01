import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';
import 'memoAdd.dart';
// import 'memoDetail.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  FirebaseDatabase _database;
  DatabaseReference reference;
  final String _databaseUrl = 'https://devcrow-flutter-example-default-rtdb.firebaseio.com/';
  List<Memo> memos = [];

  @override
  void initState() {
    super.initState();

    _database = FirebaseDatabase(databaseURL: _databaseUrl);
    reference = _database.reference().child('memo');

    reference.onChildAdded.listen((event) {
      print('Memo added: ${event.snapshot.value.toString()}');
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo App'),
      ),
      body: Container(
        child: Center(
          child: memos.length == 0 ?
          CircularProgressIndicator() :
          GridView.builder(
            itemCount: memos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: GridTile(
                  header: Text(memos[index].title),
                  footer: Text(memos[index].createTime.substring(0, 10),),
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () {

                        },
                        onLongPress: () {

                        },
                        child: Text(memos[index].content),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MemoAddPage(reference)));
        },
      ),
    );
  }
}
