import 'package:firebase_practice/model/priorityModel.dart';
import 'package:firebase_practice/serves/servece_priority.dart';
import 'package:flutter/material.dart';

class UpdatePriorities extends StatefulWidget {
  final PriorityModel model;
  UpdatePriorities({super.key, required this.model});

  @override
  State<UpdatePriorities> createState() => _UpdatePrioritiesState();
}

class _UpdatePrioritiesState extends State<UpdatePriorities> {
  TextEditingController nameCotroller = TextEditingController();
  bool isloading = false;
  @override
  void initState() {
    nameCotroller = TextEditingController(text: widget.model.name.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Priority"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: nameCotroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Update Name",
              ),
            ),
            isloading
                ? Center(child: CircularProgressIndicator())
                : MaterialButton(
                    color: Colors.blue,
                    onPressed: () async {
                      await ServecePriority()
                          .UpdatePriority(
                            PriorityModel(
                              createdAt: DateTime.now().millisecond,
                              name: nameCotroller.text,
                              docId: widget.model.docId.toString(),
                            ),
                          )
                          .then((value) {
                            setState(() {
                              isloading = false;
                            });
                            showDialog(
                              context: (context),
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Massege"),
                                  content: Text(
                                    "Task has been updated successfully",
                                  ),
                                  actions: [
                                    Center(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
