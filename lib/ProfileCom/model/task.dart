// To parse this JSON data, do
//
//     final Task = TaskFromJson(jsonString);

import 'dart:convert';
List<TaskModel> TaskFromJson(String str) => List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String TaskToJson(List<TaskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
    TaskModel({
        required this.id,
        required this.data,
        required this.type,
        required this.message,
        required this.address,
        required this.phone,
        required this.userId,
        required this.status,
    });

    String id;
    String data;
    String type;
    String message;
    String address;
    String phone;
    String userId;
    String status;

    factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        data: json["data"],
        type: json["type"],
        message: json["message"],
        address: json["address"],
        phone: json["phone"],
        userId: json["user_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
        "type": type,
        "message": message,
        "address": address,
        "phone": phone,
        "user_id": userId,
        "status": status,
    };

}
