import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference reference;

  MemoAddPage(this.reference);

  @override
  _MemoAddPageState createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Memo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(
                    labelText: 'Contents',
                  ),
                ),
              ),
              FlatButton(
                child: Text('Save'),
                onPressed: () {
                  Memo newMemo = Memo(
                    titleController.value.text.trim(),
                    contentController.value.text.trim(),
                    DateTime.now().toIso8601String(),
                  );

                  widget.reference.push().set(newMemo.toJson()).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
