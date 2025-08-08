import 'package:firebase_practice/model/priorityModel.dart';
import 'package:firebase_practice/serves/servece_priority.dart';
import 'package:flutter/material.dart';

class CreatePriorities extends StatefulWidget {
  CreatePriorities({super.key});

  @override
  State<CreatePriorities> createState() => _CreatePrioritiesState();
}

class _CreatePrioritiesState extends State<CreatePriorities> {
  TextEditingController nameController = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Priorities"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Name",
              ),
            ),
            SizedBox(height: 30),
            isloading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Enter Name")));
                        return null;
                      }
                      try {
                        setState(() {
                          isloading = true;
                        });
                        await ServecePriority()
                            .CreateServece(
                              PriorityModel(
                                name: nameController.text,
                                createdAt: DateTime.now().millisecond,
                              ),
                            )
                            .then((value) {
                              showDialog(
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Massege"),
                                    content: Text(
                                      "Task has been created successfully",
                                    ),
                                    actions: [
                                      Center(
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: Text("Create"),
                  ),
          ],
        ),
      ),
    );
  }
}
