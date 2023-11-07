import 'dart:convert';

TasksModel tasksModelFromJson(String str) => TasksModel.fromJson(json.decode(str));

String tasksModelToJson(TasksModel data) => json.encode(data.toJson());

class TasksModel {
  String? title;
  String? description;
  String? status;
  String? id;
  DateTime? date;


  TasksModel({
    this.title,
    this.description,
    this.status,
    this.id,
    this.date,
  });

  TasksModel copyWith({
    String? title,
    String? description,
    String? status,
    String? id,
    DateTime? date,
  }) =>
      TasksModel(
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        id: id ?? this.id,
        date: date ?? this.date,


      );

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
    title: json["title"],
    description: json["description"],
    status: json["status"],
    id: json["id"],
    date: json["date"].toDate(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "status": status,
    "id": id,
    "date": date,
    };
}

