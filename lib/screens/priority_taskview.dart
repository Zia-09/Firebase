import 'package:firebase_practice/model/priorityModel.dart';
import 'package:firebase_practice/model/taskModel.dart';
import 'package:firebase_practice/screens/createTask.dart';
import 'package:firebase_practice/screens/update_Task.dart';
import 'package:firebase_practice/serves/serves_Task.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PriorityTaskView extends StatelessWidget {
  final PriorityModel model;

  const PriorityTaskView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createtaskdemo()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: ServesTask().getPriorityTask(model.docId.toString()),
        initialData: [Model()],
        builder: (context, child) {
          List<Model> taskList = context.watch<List<Model>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: taskList[i].iscomplete,
                      onChanged: (val) async {
                        try {
                          await ServesTask().markTaskAsComplete(
                            taskID: taskList[i].docid.toString(),
                            isCompleted: val!,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await ServesTask().DeleteTask(taskList[i]).then((
                            val,
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Task has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateTask(model: taskList[i]),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
