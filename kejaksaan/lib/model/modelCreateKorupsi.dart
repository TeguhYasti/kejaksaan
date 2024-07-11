// To parse this JSON data, do
//
//     final modelCreateKorupsi = modelCreateKorupsiFromJson(jsonString);

import 'dart:convert';

ModelCreateKorupsi modelCreateKorupsiFromJson(String str) =>
    ModelCreateKorupsi.fromJson(json.decode(str));

String modelCreateKorupsiToJson(ModelCreateKorupsi data) =>
    json.encode(data.toJson());

class ModelCreateKorupsi {
  bool isSuccess;
  String message;

  ModelCreateKorupsi({
    required this.isSuccess,
    required this.message,
  });

  factory ModelCreateKorupsi.fromJson(Map<String, dynamic> json) =>
      ModelCreateKorupsi(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}
