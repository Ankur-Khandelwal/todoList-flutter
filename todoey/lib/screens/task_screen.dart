import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:todoey/models/tasks_data.dart';
import 'package:todoey/screens/add-task_screen.dart';
import 'package:todoey/widgets/task_list.dart';

class TaskScreen extends StatelessWidget {
  String newTask;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) => Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 40,
                  left: 30,
                  bottom: 30,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.list,
                        color: Colors.lightBlueAccent,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Todoey',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${taskData.taskCount} Tasks',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 172,
                        ),
                        FlatButton(
                          child: Icon(
                            Icons.delete_sweep,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (taskData.taskCount == 0) {
                              Toast.show("No Tasks Found", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            } else {
                              taskData.deleteAllTasksAlert(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: TasksList(taskData.task),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
            );
          },
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.add,
            size: 28,
          ),
          disabledElevation: 50,
        ),
      ),
    );
  }
}
