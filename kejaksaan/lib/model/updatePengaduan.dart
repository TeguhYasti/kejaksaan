// To parse this JSON data, do
//
//     final modelUpdatePengaduan = modelUpdatePengaduanFromJson(jsonString);

import 'dart:convert';

ModelUpdatePengaduan modelUpdatePengaduanFromJson(String str) =>
    ModelUpdatePengaduan.fromJson(json.decode(str));

String modelUpdatePengaduanToJson(ModelUpdatePengaduan data) =>
    json.encode(data.toJson());

class ModelUpdatePengaduan {
  final bool isSuccess;
  final String message;
  final Data data;

  ModelUpdatePengaduan({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelUpdatePengaduan.fromJson(Map<String, dynamic> json) =>
      ModelUpdatePengaduan(
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
  final String laporanPengaduan;
  final String fotoLaporan;
  final String kategori;
  final String status;
  final String idUser;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
