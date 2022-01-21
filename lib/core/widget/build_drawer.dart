import 'package:flutter/material.dart';
import 'package:flutter_application_hive/features/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/features/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/features/siniflar/view/sinif_view.dart';
import 'package:flutter_application_hive/features/sonuclar/view/sonuclar_select_page.dart';
import 'package:flutter_application_hive/features/temrin/view/temrin_view.dart';
import 'package:flutter_application_hive/view/mainpage.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SinifpageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: const Text(
            'Dersler',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DerspageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: const Text(
            'Öğrenciler',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OgrencipageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: const Text(
            'Temrinler',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TemrinpageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: const Text(
            'Temrin Not Girişi',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: const Text(
            'Öğrenci Puanları',
            style: TextStyle(fontSize: 24),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SonuclarSelectPage()));
          },
        ),
      ],
    ),
  );
}
