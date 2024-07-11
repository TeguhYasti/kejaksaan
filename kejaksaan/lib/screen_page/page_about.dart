import 'package:flutter/material.dart';
import 'package:kejaksaan/main.dart';
import 'package:kejaksaan/screen_page/page_profile.dart';

class PageAbouUs extends StatefulWidget {
  const PageAbouUs({super.key});

  @override
  State<PageAbouUs> createState() => _PageAbouUsState();
}

class _PageAbouUsState extends State<PageAbouUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pusat \nInformasi",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Image.asset('gambar/logo.png'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'gambar/about.png', // Menyesuaikan gambar agar memenuhi seluruh area
                ),
                SizedBox(height: 5), // Jarak 5 dari gambar
                Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Visi Kejaksaan R.I",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Menjadi Lembaga Penegak Hukum yang Professional, Proporsional dan Akuntabel",
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Misi Kejaksaan R.I",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "1. Meningkatkan Peran Kejaksaan Republik Indonesia Dalam Program Pencegahan Tindak Pidana\n"
                        "2. Meningkatkan Professionalisme Jaksa Dalam Penanganan Perkara Tindak Pidana\n"
                        "3. Meningkatkan Peran Jaksa Pengacara Negara Dalam Penyelesaian Masalah Perdata dan Tata Usaha Negara\n"
                        "4. Mewujudkan Upaya Penegakan Hukum Memenuhi Rasa Keadilan Masyarakat\n"
                        "5. Mempercepat Pelaksanaan Reformasi Birokrasi dan Tata Kelola Kejaksaan Republik Indonesia yang Bersih dan Bebas Korupsi, Kolusi dan Nepotisme",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: kToolbarHeight - 50, // Posisi panah di bawah AppBar
            left: 10, // Jarak dari sisi kiri
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Ganti dengan warna yang Anda inginkan
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
