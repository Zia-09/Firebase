import 'package:firebase_practice/model/taskModel.dart';
// import 'package:firebase_practice/practice/secondcomplete_Task.dart';
import 'package:firebase_practice/screens/complete_Task.dart';
import 'package:firebase_practice/screens/createTask.dart';
import 'package:firebase_practice/screens/getAll_priorities.dart';
import 'package:firebase_practice/screens/inComplete_Task.dart';
import 'package:firebase_practice/screens/update_Task.dart';
import 'package:firebase_practice/serves/serves_Task.dart';
// import 'package:firebase_practice/serves/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetallTask extends StatelessWidget {
  const GetallTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createtaskdemo()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Get All Task"),
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetallPriorities()),
              );
            },
            icon: Icon(Icons.category_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompleteTask()),
              );
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IncompleteTask()),
              );
            },
            icon: Icon(Icons.incomplete_circle),
          ),
        ],
      ),
      body: StreamProvider.value(
        value: ServesTask().GetAllTask(),
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
                      onChanged: (value) {
                        try {
                          ServesTask().getTaskisComplete(taskList[i]);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
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
                    IconButton(
                      onPressed: () async {
                        try {
                          await ServesTask().DeleteTask(taskList[i]).then((
                            value,
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
