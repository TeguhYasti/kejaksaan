import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kejaksaan/screen_page/page_login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    ///Wait 3 seconds and navigate to home page
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PageLogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('gambar/bg1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'gambar/kejaksaan.png',
                width: 110,
                height: 110,
              ),
            ), // Logo1 at the top
            SizedBox(height: 10), // Spacer between logo1 and text
            Text(
              'PUSAT INFORMASI',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'SUMATERA BARAT',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10), // Spacer between text and org1 image
            Image.asset(
              'gambar/org.png',
              width: 510,
              height: 510,
            ), // Org1 at the bottom
          ],
        ),
      ),
    );
  }
}
