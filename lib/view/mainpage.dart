import 'package:flutter/material.dart';
import 'package:flutter_application_hive/features/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/features/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/features/siniflar/view/sinif_view.dart';
import 'package:flutter_application_hive/features/temrin/view/temrin_view.dart';
import 'package:flutter_application_hive/features/temrinnot/view/temrinnot_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                title: const Text(
                  'Sınıflar',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SinifpageView()));
                },
              ),
              const Divider(color: Colors.black, height: 2.0),
              ListTile(
                title: const Text(
                  'Dersler',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DerspageView()));
                },
              ),
              const Divider(color: Colors.black, height: 2.0),
              ListTile(
                title: const Text(
                  'Öğrenciler',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OgrencipageView()));
                },
              ),
              const Divider(color: Colors.black, height: 2.0),
              ListTile(
                title: const Text(
                  'Temrinler',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TemrinpageView()));
                },
              ),
              const Divider(color: Colors.black, height: 2.0),
              ListTile(
                title: const Text(
                  'Temrin Not Girişi',
                  style: TextStyle(fontSize: 24),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TemrinnotpageView()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
