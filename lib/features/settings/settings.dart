import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/build_drawer.dart';
import 'package:flutter_application_hive/core/widget/custom_appbar.dart';
import 'package:flutter_application_hive/core/widget/custom_dialog_func.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/helper/ders_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/temrin_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: buildDrawer(context),
            appBar: customAppBar(context, 'TNS-Ayarlar'),
            body: Column(
              children: [
                const Center(child: Text('Uzak sunucudan data çek')),
                myCustomMenuButton(context, () {
                  siniflariGetir;
                }, const Text('Sınıfları Getir'), IconsConstans.sinifIcon, null),
                myCustomMenuButton(context, () {
                  dersleriGetir;
                }, const Text('Dersleri Getir'), IconsConstans.dersIcon, null),
                myCustomMenuButton(context, () {
                  temrinleriGetir;
                }, const Text('Temrinleri Getir'), IconsConstans.temrinIcon, null),
                myCustomMenuButton(context, () {
                  ogrencileriGetir;
                }, const Text('Öğrencileri Getir'), IconsConstans.ogrenciIcon, null),
                const Divider(color: Colors.black, height: 2.0),
                const SizedBox(height: 20),
                const Center(child: Text('Tüm dataları sil')),
                myCustomMenuButton(context, () {
                  _dialogGoster();
                }, const Text('Tüm dataları sil'), IconsConstans.warningIcon, Colors.red),
              ],
            )));
  }

  Future<void> _dialogGoster() async {
    bool durum =
        await customDialogFunc(context, 'Dikkatli olun. Eminmisiniz?', 'Tüm notlar silinsin mi?', 'Sil', 'İptal');
    // print(durum);
    durum ? _buildTemrinNotSil() : "";
    //setState(() {});
  }

  Future<void> _buildTemrinNotSil() async {
    final Box<TemrinnotModel> _box = TemrinnotBoxes.getTransactions();
    await _box.clear();
  }

  get siniflariGetir async {
    var raw = await http.get(Uri.parse(ApplicationConstants.sinifUrl));
    if (raw.statusCode == 200) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      //Logger().i('this is json Feedback ${jsonFeedback}');
      SinifListesiHelper sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);

      for (var sinif in jsonFeedback) {
        sinifListesiHelper.addItem(SinifModel(id: sinif['id'], sinifAd: sinif['sinifAd']));
      }
    } else if (raw.statusCode == 404) {
      //print('sayfa bulunamadı');
    }
  }

  get dersleriGetir async {
    var raw = await http.get(Uri.parse(ApplicationConstants.dersUrl));
    if (raw.statusCode == 200) {
      var jsonFeedback = convert.jsonDecode(raw.body);
     // Logger().i('this is json Feedback $jsonFeedback');
      DersListesiHelper dersListesiHelper = DersListesiHelper(ApplicationConstants.boxDers);

      for (var ders in jsonFeedback) {
        dersListesiHelper.addItem(DersModel(id: ders['id'], sinifId: ders['sinifId'], dersad: ders['dersAd']));
      }
    } else if (raw.statusCode == 404) {
     // Logger().e('sayfa bulunamadı');
    }
  }

  get ogrencileriGetir async {
    var raw = await http.get(Uri.parse(ApplicationConstants.ogrencilerUrl));
    if (raw.statusCode == 200) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      //Logger().i('this is json Feedback $jsonFeedback');
      OgrenciListesiHelper ogrenciListesiHelper = OgrenciListesiHelper(ApplicationConstants.boxOgrenci);

      for (var ogrenci in jsonFeedback) {
        ogrenciListesiHelper.addItem(OgrenciModel(
            id: ogrenci['id'], name: ogrenci['ogrenciName'], nu: ogrenci['ogrenciNu'], sinifId: ogrenci['sinifId']));
      }
    } else if (raw.statusCode == 404) {
      //Logger().e('sayfa bulunamadı');
    }
  }

  get temrinleriGetir async {
    var raw = await http.get(Uri.parse(ApplicationConstants.temrinUrl));
    if (raw.statusCode == 200) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      //Logger().i('this is json Feedback $jsonFeedback');
      TemrinListesiHelper temrinListesiHelper = TemrinListesiHelper(ApplicationConstants.boxTemrin);

      for (var temrin in jsonFeedback) {
        temrinListesiHelper
            .addItem(TemrinModel(id: temrin['id'], temrinKonusu: temrin['temrinKonusu'], dersId: temrin['dersId']));
      }
    } else if (raw.statusCode == 404) {
      //Logger().e('sayfa bulunamadı');
    }
  }
}
