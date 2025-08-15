import 'package:firebase_practice/model/taskModel.dart';
import 'package:firebase_practice/providers/userProviders.dart';

import 'package:firebase_practice/screens/complete_Task.dart';
import 'package:firebase_practice/screens/createTask.dart';
import 'package:firebase_practice/screens/getAll_priorities.dart';
import 'package:firebase_practice/screens/inComplete_Task.dart';
import 'package:firebase_practice/screens/login/login.dart';
// import 'package:firebase_practice/screens/priority_taskview.dart';
import 'package:firebase_practice/screens/update_Task.dart';
import 'package:firebase_practice/serves/serves_Task.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetallTask extends StatelessWidget {
  GetallTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<Userproviders>(context, listen: true);

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    // child: Icon(Icons.person, size: 50),
                    backgroundImage: AssetImage("images/cartoon.jpg"),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${userprovider.getUser().name.toString().toUpperCase() ?? "userName"}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "${userprovider.getUser().email.toString() ?? "user@gmail.com"}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Notification'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Divider(),
            ListTile(title: Text("Privecy Police")),
            ListTile(title: Text("About us")),
            ListTile(
              trailing: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                );
              },
            ),
          ],
        ),
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
                          ServesTask().markTaskAsComplete(
                            taskID: taskList[i].docid.toString(),
                            isCompleted: value!,
                          );
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
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
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
                    // IconButton(
                    //   onPressed: () async {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => PriorityTaskView(model: priorit[i].toString(),)),
                    //     );
                    //   },
                    //   icon: Icon(Icons.arrow_forward, color: Colors.blue),
                    // ),
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
