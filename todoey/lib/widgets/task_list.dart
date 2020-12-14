import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/tasks.dart';
import 'package:todoey/models/tasks_data.dart';

import 'task_tile.dart';

class TasksList extends StatelessWidget {
  final List<Task> task;
  TasksList(this.task);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) => ListView.builder(
        itemBuilder: (context, index) {
          final theTask = taskData.task[index];
          return TaskTile(
            taskName: theTask.name,
            isChecked: theTask.isDone,
            checkBoxCallback: (checkBoxState) {
              taskData.updateTask(theTask);
            },
            onLongPressCallback: () {
              taskData.deleteTaskAlert(context, theTask);
            },
          );
        },
        itemCount: taskData.taskCount,
      ),
    );
  }
}
