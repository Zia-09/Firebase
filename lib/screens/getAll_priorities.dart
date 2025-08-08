import 'package:firebase_practice/model/priorityModel.dart';
import 'package:firebase_practice/screens/create_priorities.dart';
import 'package:firebase_practice/screens/update_priorities.dart';
import 'package:firebase_practice/serves/servece_priority.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetallPriorities extends StatelessWidget {
  const GetallPriorities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePriorities()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("All priorities"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: StreamProvider.value(
              value: ServecePriority().GetAllPriorities(),
              initialData: [PriorityModel()],
              builder: (context, child) {
                List<PriorityModel> taskPriority = context
                    .watch<List<PriorityModel>>();
                return ListView.builder(
                  itemCount: taskPriority.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(taskPriority[index].name.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdatePriorities(
                                    model: taskPriority[index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () async {
                              try {
                                await ServecePriority()
                                    .DeletePriority(taskPriority[index])
                                    .then((value) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Task has been deleted successfully",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Error: ${e.toString()}"),
                                  ),
                                );
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
          ),
        ],
      ),
    );
  }
}
