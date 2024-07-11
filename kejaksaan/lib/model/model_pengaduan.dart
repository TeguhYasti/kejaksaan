// To parse this JSON data, do
//
//     final modelPengaduan = modelPengaduanFromJson(jsonString);

import 'dart:convert';

ModelPengaduan modelPengaduanFromJson(String str) =>
    ModelPengaduan.fromJson(json.decode(str));

String modelPengaduanToJson(ModelPengaduan data) => json.encode(data.toJson());

class ModelPengaduan {
  final bool isSuccess;
  final String message;
  final List<Datum> data;

  ModelPengaduan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelPengaduan.fromJson(Map<String, dynamic> json) => ModelPengaduan(
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
  final String fotoLaporan;
  final String kategori;
  final int status;
  final int idUser;

  Datum({
    required this.id,
    required this.nama,
    required this.noHp,
    required this.nik,
    required this.fotoKtp,
    required this.laporanPengaduan,
    required this.fotoLaporan,
    required this.kategori,
    required this.status,
    required this.idUser,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        noHp: json["no_hp"],
        nik: json["nik"],
        fotoKtp: json["foto_ktp"],
        laporanPengaduan: json["laporan_pengaduan"],
        fotoLaporan: json["foto_laporan"],
        kategori: json["kategori"],
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
        "foto_laporan": fotoLaporan,
        "kategori": kategori,
        "status": status,
        "id_user": idUser,
      };
}
