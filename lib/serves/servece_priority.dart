import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/model/priorityModel.dart';

class ServecePriority {
  Future CreateServece(PriorityModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("priorityCollection")
        .doc();
    return await FirebaseFirestore.instance
        .collection("priorityCollection")
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  Future UpdatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection("priorityCollection")
        .doc(model.docId)
        .update({"name": model.name});
  }

  Future DeletePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection("priorityCollection")
        .doc(model.docId)
        .delete();
  }

  Stream<List<PriorityModel>> GetAllPriorities() {
    return FirebaseFirestore.instance
        .collection("priorityCollection")
        .snapshots()
        .map(
          (priorityList) => priorityList.docs
              .map(
                (priorityJson) => PriorityModel.fromJson(priorityJson.data()),
              )
              .toList(),
        );
  }
}
