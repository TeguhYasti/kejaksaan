import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/model/model_jaksa.dart';
import 'package:kejaksaan/screen_page/admin/navbarAdmin.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/jms/detail_jaksa.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListJaksaAdmin extends StatefulWidget {
  final Datum? data;
  const PageListJaksaAdmin({this.data, super.key});

  @override
  State<PageListJaksaAdmin> createState() => _PageListJaksaAdminState();
}

class _PageListJaksaAdminState extends State<PageListJaksaAdmin> {
  bool isSearch = false;
  bool isLoading = false;
  List<Datum> jaksaList = [];
  String? idUser;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString("id");
    });
    getJaksa();
  }

  Future<void> getJaksa() async {
    if (idUser == null) return;
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http
          .get(Uri.parse('$url/db_kejaksaan/listJaksaAdmin.php?status=0'));
      if (response.statusCode == 200) {
        ModelJaksa data = modelJaksaFromJson(response.body);
        setState(() {
          jaksaList = data.data ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'gambar/bg2.jpeg', // Menyesuaikan gambar agar memenuhi seluruh area
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Ganti dengan warna yang Anda inginkan
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Admin(),
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
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'JAKSA MASUK SEKOLAH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: jaksaList.length,
                    itemBuilder: (context, index) {
                      final jaksa = jaksaList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailJaksaAdmin(Jaksa: jaksa,),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Card(
                            color: Colors.green,
                            child: ListTile(
                              minLeadingWidth: 15,
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                ],
                              ),
                              title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${jaksa.nama}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${jaksa.sekolah}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .blue, // Change to your desired button color
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        getStatusText(jaksa
                                            .status), // Add the status here
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
