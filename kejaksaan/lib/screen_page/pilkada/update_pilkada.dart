import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/model_pengaduan.dart';
import 'package:kejaksaan/model/updatePengaduan.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePilkada extends StatefulWidget {
  final Datum data;

  const UpdatePilkada({Key? key, required this.data}) : super(key: key);

  @override
  _UpdatePilkadaState createState() => _UpdatePilkadaState();
}

class _UpdatePilkadaState extends State<UpdatePilkada> {
  File? _pdfFileKTP;
  File? _pdfFileLaporan;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _laporanController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.data.nama;
    _noHpController.text = widget.data.noHp;
    _nikController.text = widget.data.nik;
    _laporanController.text = widget.data.laporanPengaduan;
  }

  Future<void> _pickFile(bool isKtp) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        if (isKtp) {
          _pdfFileKTP = File(result.files.single
              .path!); // Use File constructor to create File object
        } else {
          _pdfFileLaporan = File(result.files.single
              .path!); // Use File constructor to create File object
        }
      });
    }
  }

  Future<void> updatePilkada() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (_pdfFileKTP != null && _pdfFileLaporan != null) {
        var request = http.MultipartRequest(
            'POST', Uri.parse('$url/db_kejaksaan/updatePengaduan.php'));
        request.fields['id'] = widget.data.id.toString();
        request.fields['nama'] = _namaController.text;
        request.fields['no_hp'] = _noHpController.text;
        request.fields['nik'] = _nikController.text;
        request.fields['laporan_pengaduan'] = _laporanController.text;
        request.fields['kategori'] = "pilkada";
        request.files.add(await http.MultipartFile.fromPath(
          'foto_ktp',
          _pdfFileKTP!.path, // Use the path property of File
        ));

        request.files.add(await http.MultipartFile.fromPath(
          'foto_laporan',
          _pdfFileLaporan!.path, // Use the path property of File
        ));

        var res = await request.send();
        var resBody = await http.Response.fromStream(res);
        ModelUpdatePengaduan data = modelUpdatePengaduanFromJson(resBody.body);

        if (data.isSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
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
                              builder: (context) => MyHomePage(),
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
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'UPDATE POSKO PILKADA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'NAMA PELAPOR',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _namaController,
                            validator: (val) {
                              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'NO HP',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _noHpController,
                            validator: (val) {
                              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'KTP',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _nikController,
                            validator: (val) {
                              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickFile(true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xff167A2C), // Change the button color to green
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Menyesuaikan ukuran row sesuai dengan konten
                            children: [
                              Icon(
                                Icons.picture_as_pdf, // Menggunakan ikon PDF
                                color: Colors
                                    .white, // Mengubah warna ikon menjadi putih
                              ),
                              SizedBox(
                                  width:
                                      8), // Menambahkan sedikit jarak antara ikon dan teks
                              Text(
                                'Upload PDF',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _pdfFileKTP != null
                              ? _pdfFileKTP!.path.split('/').last
                              : (widget.data?.fotoKtp ?? 'KTP (PDF)'),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'Laporan Pengaduan',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _laporanController,
                            validator: (val) {
                              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickFile(false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xff167A2C), // Change the button color to green
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize
                                .min, // Menyesuaikan ukuran row sesuai dengan konten
                            children: [
                              Icon(
                                Icons.picture_as_pdf, // Menggunakan ikon PDF
                                color: Colors
                                    .white, // Mengubah warna ikon menjadi putih
                              ),
                              SizedBox(
                                  width:
                                      8), // Menambahkan sedikit jarak antara ikon dan teks
                              Text(
                                'Upload PDF',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _pdfFileLaporan != null
                              ? _pdfFileLaporan!.path.split('/').last
                              : (widget.data?.fotoLaporan ?? ' Laporan (PDF)'),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (keyForm.currentState?.validate() == true) {
                          updatePilkada();
                        }
                      },
                      child: Container(
                        width: 500,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff167A2C),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
