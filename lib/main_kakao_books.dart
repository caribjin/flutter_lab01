import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HttpApp());
  }
}

class HttpApp extends StatefulWidget {
  @override
  _HttpAppState createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List data;
  int page;
  TextEditingController _editingController;
  ScrollController _scrollController;

  void initState() {
    super.initState();
    data = [];
    page = 1;
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  Future<String> getJSONData() async {
    // var url = Uri.https('dapi.kakao.com', '/v3/search/book', {'target': 'title', 'page': page.toString(), 'query': _editingController.value.text});
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&page=${page.toString()}&query=${_editingController.value.text}';
    var response = await http.get(Uri.encodeFull(url), headers: {'Authorization': 'KakaoAK 54e00d0f44d0eb6dcb25c86aa57da732'});

    var jsonResponse = convert.jsonDecode(response.body);
    List documents = jsonResponse['documents'];

    data.clear();

    setState(() {
      data.addAll(documents);
    });

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(
            color: Colors.white,
          ),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: data.length == 0 ? Text(
            '데이터가 없습니다',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ) : ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Row(
                    children: [
                      Image.network(
                        data[index]['thumbnail'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              data[index]['title'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text('저자: ${data[index]['authors'].toString()}'),
                          Text('가격: ${data[index]['sale_price'].toString()}'),
                          Text('판매중: ${data[index]['status'].toString()}'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () async {
          page = 1;
          data.clear();
          getJSONData();
        },
      ),
    );
  }
}
