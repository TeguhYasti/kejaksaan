import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/model_pengaduan.dart';
import 'package:kejaksaan/screen_page/admin/navbarAdmin.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/hukum/detail_hukum.dart';
import 'package:kejaksaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListHukumAdmin extends StatefulWidget {
  final Datum? data;
  const PageListHukumAdmin({this.data, super.key});

  @override
  State<PageListHukumAdmin> createState() => _PageListHukumAdminState();
}

class _PageListHukumAdminState extends State<PageListHukumAdmin> {
  bool isSearch = false;
  bool isLoading = false;
  List<Datum> HukumList = [];
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
    getHukum();
  }

  Future<void> getHukum() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          '$url/db_kejaksaan/listPengaduanAdmin.php?status=0&kategori=hukum'));
      if (response.statusCode == 200) {
        ModelPengaduan data = modelPengaduanFromJson(response.body);
        setState(() {
          HukumList = data.data ?? [];
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

  Future<void> deleteHukum(int id) async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('$url/db_kejaksaan/deletePengaduan.php'),
        body: {'id': id.toString()}, // Convert id to String here
      );
      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData == 'success') {
          // Jika penghapusan berhasil, perbarui tampilan
          setState(() {
            HukumList.removeWhere((Hukum) => Hukum.id == id);
            isLoading = false;
          });
        } else {
          throw Exception('Failed to delete data');
        }
      } else {
        throw Exception('Failed to delete data');
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
                      'PENYULUHAN HUKUM',
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
                    itemCount: HukumList.length,
                    itemBuilder: (context, index) {
                      final Hukum = HukumList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailHukumAdmin(Hukum),
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
                                children: [],
                              ),
                              title: Text(
                                "${Hukum.nama}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${Hukum.kategori}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      getStatusText(Hukum.status),
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
