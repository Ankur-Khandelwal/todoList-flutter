import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoey/utils/database-helper.dart';

import 'tasks.dart';

class TaskData extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> _task = [];

  int get taskCount {
    return _task.length;
  }

  UnmodifiableListView<Task> get task {
    return UnmodifiableListView(_task);
  }

  void addTask(String newTaskTitle) async {
    Task task = new Task(name: newTaskTitle);
    int result = await databaseHelper.insertTask(task);
    if (result != 0) {
      _task.add(task);
      notifyListeners();
    }
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    int result = await databaseHelper.deleteTask(task.id);
    if (result != 0) {
      _task.remove(task);
      notifyListeners();
    }
  }

  void deleteAllTasks() {
    _task.clear();
    notifyListeners();
  }

  Future<void> deleteTaskAlert(BuildContext context, Task task) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete this task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                deleteTask(task);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAllTasksAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete All Tasks'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to delete all tasks?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                deleteAllTasks();
                notifyListeners();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
