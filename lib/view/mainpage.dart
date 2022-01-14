import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/custom_ders_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/core/widget/custom_sinif_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/dersler/view/ders_view.dart';
import 'package:flutter_application_hive/features/helper/ders_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/view/ogrenci_view.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/features/siniflar/view/sinif_view.dart';
import 'package:flutter_application_hive/features/temrin/view/temrin_view.dart';
import 'package:flutter_application_hive/features/temrinnot/view/temrinnot_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
  List<SinifModel> transactionsSinif = [];
  List<DersModel> transactionsDers = [];

  SinifStore viewModelSinif = SinifStore();
  DersStore viewModelDers = DersStore();

  String sinifSecText = "Sınıf Seç";
  String dersSecText = "Ders Seç";

  final DersListesiHelper _dersListesiHelper =
      DersListesiHelper(ApplicationConstants.boxDers);

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
              const Text('Sınıf:', style: TextStyle(fontSize: 18)),
              _buildSinifSec(context),
              const Text('Ders:', style: TextStyle(fontSize: 18)),
              _buildDersSec(context),
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

  _addTransactionSinif(int id, String sinifAd) async {
    final transaction = SinifModel(id: id, sinifAd: sinifAd);
    final box = SinifBoxes.getTransactions();
    box.add(transaction);
  }

  _addTransactionDers(int id, String dersad, int sinifId) async {
    final dersModel = DersModel(
        id: id, dersad: dersad, sinifId: viewModelSinif.filtreSinifId);
    final box = DersBoxes.getTransactions();
    box.add(dersModel);
  }

  List<DersModel>? _getDersItemId(int id) {
    List<DersModel> transactionsDersListesiGecici =
        DersBoxes.getTransactions().values.toList().cast<DersModel>();
    List<DersModel> transactionsDersListesiGeciciFiltre = [];

    for (var ders in transactionsDersListesiGecici) {
      if (ders.id == id) {
        transactionsDersListesiGeciciFiltre.add(ders);
      }
    }
    return transactionsDersListesiGeciciFiltre;
  }

  _buildSinifSec(BuildContext context) => myCustomMenuButton(context, () {
        showDialog(
                context: context,
                builder: (context) =>
                    CustomSinifDialog(onClickedDone: _addTransactionSinif))
            .then((value) {
          transactionsDers = [];
          if (value != null) {
            sinifSecText = value.sinifAd;
            viewModelSinif.setFiltreSinifId(value.sinifId);

            if (value.sinifId == -1) {
              sinifSecText = "Sınıf Seç";
            } else {
              transactionsDers = _getDersItemId(viewModelSinif.filtreSinifId)!;
            }
            viewModelSinif.setSinifAd(sinifSecText);
            Logger()
                .i('Seçilen sınıf id ${value.sinifId} sınıf ${value.sinifAd}');
          }
        });
      }, Observer(builder: (context) => Text(viewModelSinif.sinifAd)),
          const Icon(Icons.class__outlined));
  _buildDersSec(BuildContext context) => myCustomMenuButton(context, () {
        showDialog(
                context: context,
                builder: (context) =>
                    CustomDersDialog(onClickedDone: _addTransactionDers))
            .then((value) {
          if (value != null) {
            dersSecText = value.dersAd;
            viewModelDers.setFiltreDersId(value.dersId);
            if (value.dersId == -1) {
              dersSecText = "Ders Seç";
            }
            viewModelDers.setDersAd(dersSecText);
            Logger().i('Seçilen ders id ${value.dersId} ders: ${value.dersAd}');
          }
        });
      }, Observer(builder: (context) => Text(viewModelDers.dersAd)),
          const Icon(Icons.class__outlined));
}
