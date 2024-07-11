import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/model_login.dart';
import 'package:kejaksaan/screen_page/admin/navbarAdmin.dart';
// import 'package:kejaksaan/screen_pages/page_list_berita.dart';
import 'package:kejaksaan/screen_page/page_register.dart';
import 'package:kejaksaan/utils/cek_session.dart';
import 'package:kejaksaan/utils/ip.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  //key untuk form
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  //fungsi untuk post data
  bool isLoading = false;
  bool obscurePassword = true;
  Future<bool> loginAccount() async {
    if (keyForm.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        http.Response res = await http.post(
            Uri.parse('${url}/db_kejaksaan/login.php'),
            body: {"email": txtEmail.text, "password": txtPassword.text});

        ModelLogin data = modelLoginFromJson(res.body);

        if (data.value == 1) {
          session.saveSession(
              data.value ?? 0,
              data.id ?? "",
              data.username ?? "",
              data.email ?? "",
              data.noTlp ?? "",
              data.alamat ?? "",
              data.nik ?? "");

          if (data.isAdmin == "1") {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('admin')));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Admin()),
                (route) => false);
            return true;
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('user')));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false);
            return true;
          }
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
          isLoading = false;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'gambar/kejaksaan.png',
                  scale: 9.0,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'KEJAKSAAN SUMBAR',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: txtEmail,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.perm_identity_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xff86FAA7)),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons
                          .lock_outline_rounded), // Icon gembok di sebelah kiri
                      suffixIcon: IconButton(
                        onPressed: () {
                          // Tampilkan atau sembunyikan teks password
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ), // Icon mata di sebelah kanan
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xff86FAA7)),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    if (keyForm.currentState?.validate() == true) {
                      //kita panggil function login
                      loginAccount();
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
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have  an Account ?'),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageRegister(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
