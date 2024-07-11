import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/modelCreateJaksa.dart';
import 'package:kejaksaan/model/model_register.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageJaksa extends StatefulWidget {
  const PageJaksa({super.key});

  @override
  State<PageJaksa> createState() => _PageJaksaState();
}

class _PageJaksaState extends State<PageJaksa> {
  final _formKey = GlobalKey<FormState>();
  final _sekolahController = TextEditingController();
  final _namaController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      print('id $id');
      print('username $username');
    });
  }

  Future<bool> _AddJMS() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        http.Response res = await http
            .post(Uri.parse('$url/db_kejaksaan/insertJaksa.php'), body: {
          "nama": _namaController.text,
          "sekolah": _sekolahController.text,
          "id_user": id
        });

        ModelCreateJaksa data = modelCreateJaksaFromJson(res.body);

        if (data.isSuccess == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
            (route) => false,
          );
          return true;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          return false;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        return false;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    return false;
  }

  @override
  void dispose() {
    _sekolahController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'gambar/bg2.jpeg', // Menyesuaikan gambar agar memenuhi seluruh area
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Colors.white, // Ganti dengan warna yang Anda inginkan
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
                      scale: 10, // Mengatur skala gambar
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'JAKSA MASUK SEKOLAH',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '(JMS)',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100, // Adjust this width as needed
                          child: Text(
                            'SEKOLAH YANG DITUJU',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                          width: 100, // Adjust this width as needed
                          child: Text(
                            'NAMA PEMOHON',
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
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() == true) {
                          //kita panggil function login
                          _AddJMS();
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
