import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kejaksaan/model/model_korupsi.dart';
import 'package:kejaksaan/model/model_status.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/korupsi/page_listkorupsi.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DetailKorupsiAdmin extends StatelessWidget {
  final Datum korupsi;

  DetailKorupsiAdmin({required this.korupsi});

  Future<String> _downloadFile(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String fileName = url.split('/').last;
    final File file = File('$tempPath/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<void> approvePengaduan(
      BuildContext context, String idp, String status) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${url}/db_kejaksaan/updateKorupsiAdmin.php'),
          body: {"status": status, "id": idp});

      // Periksa apakah permintaan berhasil (status kode 200)
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelUpdateStatus data = modelUpdateStatusFromJson(res.body);

        if (data.isSuccess == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListKorupsiAdmin()),
              (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah Data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Approved';
      case 2:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'gambar/bg2.jpeg',
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListKorupsiAdmin(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'gambar/kejaksaan.png',
                    scale: 10,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Detail Pengaduan Tindak Pidana \n Korupsi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Nama',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${korupsi.nama ?? ''}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${getStatusText(korupsi.status ?? 0)}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Nik',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${korupsi.nik ?? ''}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Nomor HP',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${korupsi.noHp ?? ''}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Laporan Pengaduan',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${korupsi.laporanPengaduan ?? ''}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Laporan Uraian Singkat',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(': '),
                      Expanded(
                        flex: 4,
                        child: Text('${korupsi.uraianLaporan ?? ''}',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Foto KTP :',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  FutureBuilder<String>(
                    future: _downloadFile(
                        '$url/db_kejaksaan/upload/${korupsi.fotoKtp}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 400,
                            child: PDFView(
                              filePath: snapshot.data,
                            ),
                          );
                        } else {
                          return Text('Gagal memuat gambar KTP');
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Foto Laporan:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  FutureBuilder<String>(
                    future: _downloadFile(
                        '$url/db_kejaksaan/upload/${korupsi.fotoLaporan}'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Container(
                            height: 400,
                            child: PDFView(
                              filePath: snapshot.data,
                            ),
                          );
                        } else {
                          return Text('Gagal memuat pratinjau PDF');
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.redAccent),
                          ),
                          onPressed: () {
                            approvePengaduan(
                                context, korupsi.id.toString(), "2");
                          },
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.greenAccent),
                          ),
                          onPressed: () {
                            approvePengaduan(
                                context, korupsi.id.toString(), "1");
                          },
                          child: Text(
                            "Approve",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
