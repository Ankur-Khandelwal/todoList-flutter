import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskName;
  final Function checkBoxCallback;
  final Function onLongPressCallback;

  TaskTile(
      {this.taskName,
      this.isChecked,
      this.checkBoxCallback,
      this.onLongPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskName,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkBoxCallback,
      ),
      onLongPress: onLongPressCallback,
    );
  }
}
