import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kejaksaan/screen_page/page_login.dart';
import 'package:kejaksaan/utils/ip.dart';

class PagePenilaian extends StatefulWidget {
  const PagePenilaian({super.key});

  @override
  State<PagePenilaian> createState() => _PagePenilaianState();
}

class _PagePenilaianState extends State<PagePenilaian> {
  int _rating = 0;
  final TextEditingController _pesanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showRatingDialog());
  }

  Future<void> _submitPenilaian() async {
    final response = await http.post(
      Uri.parse('$url/db_kejaksaan/insertPenilaian.php'),
      body: {
        'rating': _rating.toString(),
        'pesan': _pesanController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Penilaian berhasil dikirim')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PageLogin(), // Replace with your login page class
        ),
        (route) => false,
      );
    } else {
      // Handle submission error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Penilaian gagal dikirim')),
      );
    }
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('RATING'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                    ),
                    color: Colors.amber,
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              TextField(
                controller: _pesanController,
                decoration: InputDecoration(labelText: 'Pesan'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _submitPenilaian();
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabel Penilaian'),
      ),
      body: Center(
        child: Text('Mohon tunggu...'),
      ),
    );
  }
}
