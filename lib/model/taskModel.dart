// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

class Model {
  String? docid;
  String? title;
  String? description;
  String? priorityID;
  String? image;
  bool? iscomplete;
  int? createAt;

  Model({
    this.docid,
    this.title,
    this.description,
    this.priorityID,
    this.image,
    this.iscomplete,
    this.createAt,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    docid: json["docid"],
    title: json["title"],
    description: json["description"],
    priorityID: json["priorityID"],
    image: json["image"],
    iscomplete: json["iscomplete"],
    createAt: json["createAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docid": taskID,
    "title": title,
    "description": description,
    "priorityID": priorityID,
    "image": image,
    "iscomplete": iscomplete,
    "createAt": createAt,
  };
}
