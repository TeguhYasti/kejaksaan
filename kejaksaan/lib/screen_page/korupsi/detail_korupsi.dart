import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kejaksaan/model/model_korupsi.dart';
import 'package:kejaksaan/screen_page/korupsi/page_listkorupsi.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DetailKorupsi extends StatelessWidget {
  final Datum pengaduan;

  DetailKorupsi({required this.pengaduan});

  Future<String> _downloadFile(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String fileName = url.split('/').last;
    final File file = File('$tempPath/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
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
                            builder: (context) => PageListKorupsi(),
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
                        child: Text('${pengaduan.nama ?? ''}',
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
                        child: Text('${getStatusText(pengaduan.status ?? 0)}',
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
                        child: Text('${pengaduan.nik ?? ''}',
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
                        child: Text('${pengaduan.noHp ?? ''}',
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
                        child: Text('${pengaduan.laporanPengaduan ?? ''}',
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
                        child: Text('${pengaduan.uraianLaporan ?? ''}',
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
                        '$url/db_kejaksaan/upload/${pengaduan.fotoKtp}'),
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
                        '$url/db_kejaksaan/upload/${pengaduan.fotoLaporan}'),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
