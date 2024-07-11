// To parse this JSON data, do
//
//     final modelUpdateStatus = modelUpdateStatusFromJson(jsonString);

import 'dart:convert';

ModelUpdateStatus modelUpdateStatusFromJson(String str) =>
    ModelUpdateStatus.fromJson(json.decode(str));

String modelUpdateStatusToJson(ModelUpdateStatus data) =>
    json.encode(data.toJson());

class ModelUpdateStatus {
  bool isSuccess;
  String message;

  ModelUpdateStatus({
    required this.isSuccess,
    required this.message,
  });

  factory ModelUpdateStatus.fromJson(Map<String, dynamic> json) =>
      ModelUpdateStatus(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}