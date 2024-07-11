// To parse this JSON data, do
//
//     final modelJaksa = modelJaksaFromJson(jsonString);

import 'dart:convert';

ModelJaksa modelJaksaFromJson(String str) =>
    ModelJaksa.fromJson(json.decode(str));

String modelJaksaToJson(ModelJaksa data) => json.encode(data.toJson());

class ModelJaksa {
  final bool isSuccess;
  final String message;
  final List<Datum> data;

  ModelJaksa({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelJaksa.fromJson(Map<String, dynamic> json) => ModelJaksa(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final String sekolah;
  final String nama;
  final int status;
  final int idUser;

  Datum({
    required this.id,
    required this.sekolah,
    required this.nama,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
