// To parse this JSON data, do
//
//     final modelUpdateJaksa = modelUpdateJaksaFromJson(jsonString);

import 'dart:convert';

ModelUpdateJaksa modelUpdateJaksaFromJson(String str) =>
    ModelUpdateJaksa.fromJson(json.decode(str));

String modelUpdateJaksaToJson(ModelUpdateJaksa data) =>
    json.encode(data.toJson());

class ModelUpdateJaksa {
  final bool isSuccess;
  final String message;
  final Data data;

  ModelUpdateJaksa({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelUpdateJaksa.fromJson(Map<String, dynamic> json) =>
      ModelUpdateJaksa(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final String id;
  final String sekolah;
  final String nama;
  final String status;
  final String idUser;

  Data({
    required this.id,
    required this.sekolah,
    required this.nama,
    required this.status,
    required this.idUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sekolah: json["sekolah"],
        nama: json["nama"],
        status: json["status"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sekolah": sekolah,
        "nama": nama,
        "status": status,
        "id_user": idUser,
      };
}
