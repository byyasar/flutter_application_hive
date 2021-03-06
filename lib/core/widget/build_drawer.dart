import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/constants/image_constants.dart';
import 'package:flutter_application_hive/core/widget/exitapp_dialog.dart';
import 'package:flutter_application_hive/features/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/features/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/features/settings/settings.dart';
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
            image: DecorationImage(
              image: AssetImage(ImageConstants.logo),
              fit: BoxFit.fill,
            ),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              'Temrin Not Sistemi v1',
              style: TextStyle(fontSize: 22, color: Colors.black, backgroundColor: Colors.white),
            ),
          ),
        ),
        ListTile(
          title: Row(children: const [
            IconsConstans.sinifIcon,
            SizedBox(width: 5),
            Text('Sınıflar', style: TextStyle(fontSize: 20))
          ]),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SinifpageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.dersIcon,
              SizedBox(width: 5),
              Text('Dersler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DerspageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.ogrenciIcon,
              SizedBox(width: 5),
              Text('Öğrenciler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OgrencipageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.temrinIcon,
              SizedBox(width: 5),
              Text('Temrinler', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TemrinpageView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.temrinnotIcon,
              SizedBox(width: 5),
              Text('Temrin Not Girişi', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.puanlarIcon,
              SizedBox(width: 5),
              Text('Öğrenci Puanları', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SonuclarSelectPage()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.settingsIcon,
              SizedBox(width: 5),
              Text('Ayarlar', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsView()));
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
        ListTile(
          title: Row(
            children: const [
              IconsConstans.exitIcon,
              SizedBox(width: 5),
              Text('Çıkış', style: TextStyle(fontSize: 20)),
            ],
          ),
          onTap: () {
            //SystemNavigator.pop();
            //exit(0);
            exitAppDialog(context);
          },
        ),
        const Divider(color: Colors.black, height: 2.0),
      ],
    ),
  );
}
