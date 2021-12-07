import 'package:flutter/material.dart';
import 'package:flutter_application_hive/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/siniflar/view/sinif_view.dart';
import 'package:flutter_application_hive/temrin/view/temrin_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temrin Not Sistemi')),
      body: const Center(
        child: Text('Temrin Not Girişi'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Temrin Not Sistemi v1',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Sınıflar'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SinifpageView()));
              },
            ),
            ListTile(
              title: const Text('Dersler'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DerspageView()));
              },
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const OgrencipageView()));
              },
            ),
            ListTile(
              title: const Text('Temrinler'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TemrinpageView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
