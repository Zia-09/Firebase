import 'package:firebase_practice/model/taskModel.dart';
import 'package:firebase_practice/serves/serves_Task.dart';
import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  final Model model;
  UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptiontitleController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController(
      text: widget.model.title.toString(),
    );
    descriptiontitleController = TextEditingController(
      text: widget.model.description.toString(),
    );
    // TODO: implement initState
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Task"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(controller: titleController),
            TextField(controller: descriptiontitleController),
            SizedBox(height: 30),
            isloading
                ? CircularProgressIndicator()
                : MaterialButton(
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          descriptiontitleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Fields can't be empty",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return null;
                      }
                      try {
                        setState(() {
                          isloading = true;
                        });
                        ServesTask()
                            .UpdateTask(
                              Model(
                                docid: widget.model.docid.toString(),
                                title: titleController.text,
                                description: descriptiontitleController.text,
                              ),
                            )
                            .then((value) {
                              setState(() {
                                isloading = false;
                                showDialog(
                                  context: (context),
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Massege"),
                                      content: Text(
                                        "Your Task has been updated successfully",
                                      ),
                                      actions: [
                                        MaterialButton(
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
                                      ],
                                    );
                                  },
                                );
                              });
                            });
                      } catch (e) {}
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
          ],
        ),
      ),
    );
  }
}
