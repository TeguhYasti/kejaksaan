import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/agama/page_listagama.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/hukum/page_listpenyuluhan.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/jms/page_listjaksa.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/korupsi/page_listkorupsi.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/pegawai/page_listpegawai.dart';
import 'package:kejaksaan/screen_page/admin/pengaduan/pilkada/page_listpilkada.dart';

class HomeIndexAdmin extends StatefulWidget {
  const HomeIndexAdmin({super.key});

  @override
  State<HomeIndexAdmin> createState() => _HomeIndexAdminState();
}

class _HomeIndexAdminState extends State<HomeIndexAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pusat \nInformasi ",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        leading: Image.asset('gambar/logo.png'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ///Base
                BannerCarousel(
                  banners: BannerImages.listBanners,
                  onTap: (id) => print(id),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            Text(
              "Pusat Layanan Informasi",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListPegawaiAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/jaksa5.png')),
                            SizedBox(height: 2),
                            Text(
                              'Pengaduan\nPegawai',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListKorupsiAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/korupsi.png')),
                            SizedBox(height: 2),
                            Text(
                              'Pengaduan Tindak\nPidana Korupsi',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListJaksaAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/jaksa1.png')),
                            SizedBox(height: 2),
                            Text(
                              'JMS (Jaksa \n Masuk Sekolah)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListHukumAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/jaksa2.png')),
                            SizedBox(height: 2),
                            Text(
                              'Penyuluhan \nHukum',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListAgamaAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/jaksa3.png')),
                            SizedBox(height: 2),
                            Text(
                              'Pengawasan Aliran \ndan Kepercayaan',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageListPilkadaAdmin(),
                          ),
                          (route) => false,
                        );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset('gambar/jaksa4.png')),
                            SizedBox(height: 2),
                            Text(
                              'Posko \nPilkada',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class BannerImages {
  static const String banner1 =
      "https://kejari-indragirihulu.go.id/wp-content/uploads/2019/07/STOP-KORUPSI.png";

  static const String banner2 =
      "https://kejari-indragirihulu.go.id/wp-content/uploads/2019/07/etilang-banner-copy.jpg";
  static const String banner3 =
      "https://kejari-batam.go.id/wp-content/uploads/2022/05/banner_Barang-2.png";
  static const String banner4 =
      "https://kejari-kotatangerang.kejaksaan.go.id/uploads/layanan/0fa34dee4f40344ff7764a21ba8daf99.jpg";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
    BannerModel(imagePath: banner4, id: "4"),
  ];
}
