import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kejaksaan/model/model_pengaduan.dart';
import 'package:kejaksaan/model/model_status.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/agama/page_listagama.dart';

import 'package:kejaksaan/utils/ip.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DetailAgamaAdmin extends StatelessWidget {
  final Datum data;
  const DetailAgamaAdmin(this.data, {super.key});

  Future<void> approvePengaduan(
      BuildContext context, String idp, String status) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${url}/db_kejaksaan/updatePengaduanStatus.php'),
          body: {"status": status, "id": idp.toString()});

      if (res.statusCode == 200) {
        ModelUpdateStatus data = modelUpdateStatusFromJson(res.body);

        if (data.isSuccess == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListAgamaAdmin()),
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

  Future<String> _downloadFile(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = tempDir.path;
        final String fileName = url.split('/').last;
        final File file = File('$tempPath/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Approve';
      case 2:
        return 'Reject';
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
                            builder: (context) => PageListAgamaAdmin(),
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
                      'Detail Pengaduan Pengawasan Aliran dan\nKepercayaan',
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
                        child: Text('${data.nama ?? ''}',
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
                        child: Text('${getStatusText(data.status ?? 0)}',
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
                        child: Text('${data.nik ?? ''}',
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
                        child: Text('${data.noHp ?? ''}',
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
                        child: Text('${data.laporanPengaduan ?? ''}',
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
                        '$url/db_kejaksaan/upload/${data.fotoKtp}'),
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
                        '$url/db_kejaksaan/upload/${data.fotoLaporan}'),
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
                            approvePengaduan(context, data.id.toString(), "2");
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
                            approvePengaduan(context, data.id.toString(), "1");
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
