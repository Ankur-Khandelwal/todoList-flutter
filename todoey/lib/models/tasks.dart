class Task {
  String name;
  bool isDone;
  int id;

  Task({this.name, this.isDone = false});

  Task.withId(this.id, this.name, this.isDone);

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
      map['taskName'] = name;
      map['taskStatus'] = isDone ? 1 : 0;
    }
    return map;
  }

  Task.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['taskName'];
    this.isDone = map['taskStatus'] == 1 ? true : false;
  }
}
