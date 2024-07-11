// To parse this JSON data, do
//
//     final modelUpdateKorupsi = modelUpdateKorupsiFromJson(jsonString);

import 'dart:convert';

ModelUpdateKorupsi modelUpdateKorupsiFromJson(String str) =>
    ModelUpdateKorupsi.fromJson(json.decode(str));

String modelUpdateKorupsiToJson(ModelUpdateKorupsi data) =>
    json.encode(data.toJson());

class ModelUpdateKorupsi {
  final bool isSuccess;
  final String message;
  final Data data;

  ModelUpdateKorupsi({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelUpdateKorupsi.fromJson(Map<String, dynamic> json) =>
      ModelUpdateKorupsi(
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
  final String nama;
  final String noHp;
  final String nik;
  final String fotoKtp;
  final String uraianLaporan;
  final String laporanPengaduan;
  final String fotoLaporan;
  final String status;
  final String idUser;

  Data({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.nik,
    required this.fotoKtp,
    required this.uraianLaporan,
    required this.laporanPengaduan,
    required this.fotoLaporan,
    required this.status,
    required this.idUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
        noHp: json["no_hp"],
        nik: json["nik"],
        fotoKtp: json["foto_ktp"],
        uraianLaporan: json["uraian_laporan"],
        laporanPengaduan: json["laporan_pengaduan"],
        fotoLaporan: json["foto_laporan"],
        status: json["status"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "no_hp": noHp,
        "nik": nik,
        "foto_ktp": fotoKtp,
        "uraian_laporan": uraianLaporan,
        "laporan_pengaduan": laporanPengaduan,
        "foto_laporan": fotoLaporan,
        "status": status,
        "id_user": idUser,
      };
}
