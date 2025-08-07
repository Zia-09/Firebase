import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/model/taskModel.dart';

class ServesTask {
  Future createTask(Model model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Mycollection")
        .doc();
    return await FirebaseFirestore.instance
        .collection("Mycollection")
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  Future UpdateTask(Model model) async {
    return await FirebaseFirestore.instance
        .collection("Mycollection")
        .doc(model.docid)
        .update({"description": model.description, "title": model.title});
  }

  Future DeleteTask(Model model) async {
    return await FirebaseFirestore.instance
        .collection("Mycollection")
        .doc(model.docid)
        .delete();
  }

  Future getTaskisComplete(Model model) async {
    return await FirebaseFirestore.instance
        .collection("Mycollection")
        .doc(model.docid)
        .update({"iscomplete": true});
  }

  // Get completed tasks

  Stream<List<Model>> GetCompleteTask() {
    return FirebaseFirestore.instance
        .collection("Mycollection")
        .where("iscomplete", isEqualTo: true)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => Model.fromJson(taskJson.data()))
              .toList(),
        );
  }

  // Get Incomplete Tasks

  Stream<List<Model>> GetIncomplete() {
    return FirebaseFirestore.instance
        .collection("Mycollection")
        .where("iscomplete", isEqualTo: false)
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => Model.fromJson(taskJson.data()))
              .toList(),
        );
  }

  // Get All Task
  Stream<List<Model>> GetAllTask() {
    return FirebaseFirestore.instance
        .collection("Mycollection")
        .snapshots()
        .map(
          (taskList) => taskList.docs
              .map((taskJson) => Model.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
