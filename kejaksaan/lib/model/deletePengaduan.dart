// To parse this JSON data, do
//
//     final modelDeletePengaduan = modelDeletePengaduanFromJson(jsonString);

import 'dart:convert';

ModelDeletePengaduan modelDeletePengaduanFromJson(String str) =>
    ModelDeletePengaduan.fromJson(json.decode(str));

String modelDeletePengaduanToJson(ModelDeletePengaduan data) =>
    json.encode(data.toJson());

class ModelDeletePengaduan {
  final String status;
  final String message;

  ModelDeletePengaduan({
    required this.status,
    required this.message,
  });

  factory ModelDeletePengaduan.fromJson(Map<String, dynamic> json) =>
      ModelDeletePengaduan(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
