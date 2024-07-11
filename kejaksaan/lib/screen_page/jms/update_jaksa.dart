import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/model_jaksa.dart';
import 'package:kejaksaan/model/updateJaksa.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateJaksa extends StatefulWidget {
  final Datum data;

  const UpdateJaksa({Key? key, required this.data}) : super(key: key);

  @override
  _UpdateJaksaState createState() => _UpdateJaksaState();
}

class _UpdateJaksaState extends State<UpdateJaksa> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _sekolahController = TextEditingController();

  bool isLoading = false;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _namaController.text = widget.data.nama;
    _sekolahController.text = widget.data.sekolah;
  }

  Future<void> updateJaksa() async {
    try {
      setState(() {
        isLoading = true;
      });

      var request = http.MultipartRequest(
          'POST', Uri.parse('$url/db_kejaksaan/updateJaksa.php'));
      request.fields['id'] = widget.data.id.toString();
      request.fields['nama'] = _namaController.text;
      request.fields['sekolah'] = _sekolahController.text;

      var res = await request.send();
      var resBody = await http.Response.fromStream(res);
      if (resBody.statusCode == 200) {
        ModelUpdateJaksa data = modelUpdateJaksaFromJson(resBody.body);

        if (data.isSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
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
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'gambar/kejaksaan.png',
                      scale: 10,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      ' UPDATE JAKSA MASUK SEKOLAH',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'SEKOLAH',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _sekolahController,
                            validator: (val) {
                              return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            'NAMA',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        if (keyForm.currentState?.validate() == true) {
                          updateJaksa();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
