// To parse this JSON data, do
//
//     final modelCreatePengaduan = modelCreatePengaduanFromJson(jsonString);

import 'dart:convert';

ModelCreatePengaduan modelCreatePengaduanFromJson(String str) =>
    ModelCreatePengaduan.fromJson(json.decode(str));

String modelCreatePengaduanToJson(ModelCreatePengaduan data) =>
    json.encode(data.toJson());

class ModelCreatePengaduan {
  bool isSuccess;
  String message;

  ModelCreatePengaduan({
    required this.isSuccess,
    required this.message,
  });

  factory ModelCreatePengaduan.fromJson(Map<String, dynamic> json) =>
      ModelCreatePengaduan(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}
