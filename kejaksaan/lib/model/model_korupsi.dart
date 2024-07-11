// To parse this JSON data, do
//
//     final modelKorupsi = modelKorupsiFromJson(jsonString);

import 'dart:convert';

ModelKorupsi modelKorupsiFromJson(String str) =>
    ModelKorupsi.fromJson(json.decode(str));

String modelKorupsiToJson(ModelKorupsi data) => json.encode(data.toJson());

class ModelKorupsi {
  final bool isSuccess;
  final String message;
  final List<Datum> data;

  ModelKorupsi({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelKorupsi.fromJson(Map<String, dynamic> json) => ModelKorupsi(
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
  final String nama;
  final String noHp;
  final String nik;
  final String fotoKtp;
  final String laporanPengaduan;
  final String uraianLaporan;
  final String fotoLaporan;
  final int status;
  final int idUser;

  Datum({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.nik,
    required this.fotoKtp,
    required this.laporanPengaduan,
    required this.uraianLaporan,
    required this.fotoLaporan,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        "laporan_pengaduan": laporanPengaduan,
        "uraian_laporan": uraianLaporan,
        "foto_laporan": fotoLaporan,
        "status": status,
        "id_user": idUser,
      };
}
