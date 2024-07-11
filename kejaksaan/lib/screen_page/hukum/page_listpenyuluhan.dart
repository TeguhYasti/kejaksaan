import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/model/deletePengaduan.dart';
import 'package:kejaksaan/model/model_pengaduan.dart';
import 'package:kejaksaan/screen_page/hukum/detail_hukum.dart';
import 'package:kejaksaan/screen_page/hukum/page_hukum.dart';
import 'package:kejaksaan/screen_page/hukum/update_hukum.dart';

import 'package:kejaksaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageListPenyuluhan extends StatefulWidget {
  final Datum? data;
  const PageListPenyuluhan({this.data, super.key});

  @override
  State<PageListPenyuluhan> createState() => _PageListPenyuluhanState();
}

class _PageListPenyuluhanState extends State<PageListPenyuluhan> {
  bool isSearch = false;
  bool isLoading = false;
  List<Datum> penyuluhanList = [];
  String? idUser;

  @override
  void initState() {
    super.initState();
    getUserId();
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

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString("id");
    });
    getPegawai();
  }

  Future<void> getPegawai() async {
    if (idUser == null) return;
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(Uri.parse(
          '$url/db_kejaksaan/listPengaduan.php?id_user=$idUser&kategori=hukum'));
      if (response.statusCode == 200) {
        ModelPengaduan data = modelPengaduanFromJson(response.body);
        setState(() {
          penyuluhanList = data.data ?? [];
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

  Future<void> deletePengaduan(int id) async {
    var idPengaduan = id;
    try {
      setState(() {
        isLoading = false;
      });
      http.Response res = await http.post(
          Uri.parse('$url/db_kejaksaan/deletePengaduan.php'),
          body: {"id": idPengaduan.toString()});

      // Periksa apakah permintaan berhasil (status kode 200)
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelDeletePengaduan data = modelDeletePengaduanFromJson(res.body);

        if (data.status == "success") {
          setState(() {
            penyuluhanList
                .removeWhere((pegawai) => pegawai.id == id.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          });

          setState(() {
            getPegawai();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus Data')),
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PageHukum()));
        },
        tooltip: "tambah penyuluhan",
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
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
                    itemCount: penyuluhanList.length,
                    itemBuilder: (context, index) {
                      final pegawai = penyuluhanList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailHukum(pengaduan: pegawai),
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
                                  IconButton(
                                    tooltip: "hapus data",
                                    onPressed: () {
                                      String idToDelete = pegawai.id
                                          .toString(); // Fix this line

                                      if (int.tryParse(idToDelete) != null) {
                                        deletePengaduan(int.parse(idToDelete));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('ID tidak valid')),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: "edit data",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateHukum(data: pegawai)));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${pegawai.nama}",
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
                                      "${pegawai.kategori}",
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
                                        getStatusText(pegawai
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
