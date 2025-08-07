import 'package:firebase_practice/model/taskModel.dart';
import 'package:firebase_practice/serves/serves_Task.dart';
import 'package:flutter/material.dart';

class Createtaskdemo extends StatefulWidget {
  const Createtaskdemo({super.key});

  @override
  State<Createtaskdemo> createState() => _CreatetaskdemoState();
}

class _CreatetaskdemoState extends State<Createtaskdemo> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Task"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "description",
              ),
            ),
            SizedBox(height: 30),
            isloading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Enter Title")));
                        return null;
                      }
                      if (descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter Description")),
                        );
                        return null;
                      }
                      try {
                        isloading = true;
                        setState(() {});
                        await ServesTask()
                            .createTask(
                              Model(
                                title: titleController.text,
                                description: descriptionController.text,
                                createAt: DateTime.now().millisecond,
                                iscomplete: false,
                              ),
                            )
                            .then((value) {
                              isloading = false;
                              setState(() {});
                              showDialog(
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Massege"),
                                    content: Text(
                                      "Task has been add Sucssufuly ",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Okay"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      } catch (e) {
                        isloading = false;
                        setState(() {});
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text("Submit"),
                  ),
          ],
        ),
      ),
    );
  }
}
