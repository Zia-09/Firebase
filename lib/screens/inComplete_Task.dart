import 'package:firebase_practice/model/taskModel.dart';
import 'package:firebase_practice/serves/serves_Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncompleteTask extends StatelessWidget {
  const IncompleteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incomplete Task"), centerTitle: true),
      body: StreamProvider.value(
        value: ServesTask().GetIncomplete(),
        initialData: [Model()],
        builder: (context, child) {
          List<Model> taskModel = context.watch<List<Model>>();
          return ListView.builder(
            itemCount: taskModel.length,

            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.task),

                title: Text(taskModel[index].title.toString()),
                subtitle: Text(taskModel[index].description.toString()),
                trailing: IconButton(
                  onPressed: () async {
                    try {
                      await ServesTask().DeleteTask(taskModel[index]).then((
                        value,
                      ) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Task has been deleted successfully",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: ${e.toString()}")),
                      );
                    }
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
