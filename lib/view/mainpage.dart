import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/features/helper/ders_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/view/sinif_view.dart';
import 'package:flutter_application_hive/features/temrin/view/temrin_view.dart';
import 'package:flutter_application_hive/features/temrinnot/view/temrinnot_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context),
        appBar: AppBar(title: const Text('Temrin Not Sistemi')),
        body: Center(
          child: Column(
            children: [
              const Text('Temrin Not Girişi'),
              myCustomMenuButton(context, () {}, 'Sınıf Seçiniz',
                  const Icon(Icons.class__outlined)),
              myCustomMenuButton(context, () {}, 'Ders Seçiniz',
                  const Icon(Icons.play_lesson)),
              myCustomMenuButton(
                  context, () {}, 'Temrin Seçiniz', const Icon(Icons.work)),
            ],
          ),
        ),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
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
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
              onPressed: () {}, label: const Text('Temrin Not Gir')),
          FloatingActionButton(
              heroTag: 'temrin',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.note),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TemrinnotpageView()));
              }),
          FloatingActionButton(
              heroTag: 'data',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.data_saver_off),
              onPressed: () async {
                var raw =
                    await http.get(Uri.parse(ApplicationConstants.sinifUrl));
                if (raw.statusCode == 200) {
                  var jsonFeedback = convert.jsonDecode(raw.body);
                  //Logger().i('this is json Feedback ${jsonFeedback}');
                  SinifListesiHelper sinifListesiHelper =
                      SinifListesiHelper(ApplicationConstants.boxSinif);

                  for (var sinif in jsonFeedback) {
                    sinifListesiHelper.addItem(
                        SinifModel(id: sinif['id'], sinifAd: sinif['sinifAd']));
                  }
                } else if (raw.statusCode == 404) {
                  //print('sayfa bulunamadı');
                }
              }),
          FloatingActionButton(
              heroTag: 'dataders',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.data_saver_on),
              onPressed: () async {
                var raw =
                    await http.get(Uri.parse(ApplicationConstants.dersUrl));
                if (raw.statusCode == 200) {
                  var jsonFeedback = convert.jsonDecode(raw.body);
                  Logger().i('this is json Feedback $jsonFeedback');
                  DersListesiHelper dersListesiHelper =
                      DersListesiHelper(ApplicationConstants.boxDers);

                  for (var ders in jsonFeedback) {
                    dersListesiHelper.addItem(DersModel(
                        id: ders['id'],
                        sinifId: ders['sinifId'],
                        dersad: ders['dersAd']));
                  }
                } else if (raw.statusCode == 404) {
                  Logger().e('sayfa bulunamadı');
                }
              }),
          FloatingActionButton(
              heroTag: 'dataOgrenci',
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.star_rounded),
              onPressed: () async {
                var raw = await http
                    .get(Uri.parse(ApplicationConstants.ogrencilerUrl));
                if (raw.statusCode == 200) {
                  var jsonFeedback = convert.jsonDecode(raw.body);
                  Logger().i('this is json Feedback $jsonFeedback');
                  OgrenciListesiHelper ogrenciListesiHelper =
                      OgrenciListesiHelper(ApplicationConstants.boxOgrenci);

                  for (var ogrenci in jsonFeedback) {
                    ogrenciListesiHelper.addItem(OgrenciModel(
                        id: ogrenci['id'],
                        name: ogrenci['ogrenciName'],
                        nu: ogrenci['ogrenciNu'],
                        sinifId: ogrenci['sinifId']));
                  }
                } else if (raw.statusCode == 404) {
                  Logger().e('sayfa bulunamadı');
                }
              }),
        ],
      ),
    );
  }
}
