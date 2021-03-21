class Todo {
  int id;
  String title;
  String content;
  bool active;

  Todo({this.id, this.title, this.content, this.active});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'active': active
    };
  }
}
