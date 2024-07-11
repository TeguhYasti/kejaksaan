// To parse this JSON data, do
//
//     final modelCreateJaksa = modelCreateJaksaFromJson(jsonString);

import 'dart:convert';

ModelCreateJaksa modelCreateJaksaFromJson(String str) =>
    ModelCreateJaksa.fromJson(json.decode(str));

String modelCreateJaksaToJson(ModelCreateJaksa data) =>
    json.encode(data.toJson());

class ModelCreateJaksa {
  bool isSuccess;
  String message;

  ModelCreateJaksa({
    required this.isSuccess,
    required this.message,
  });

  factory ModelCreateJaksa.fromJson(Map<String, dynamic> json) =>
      ModelCreateJaksa(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
      };
}
