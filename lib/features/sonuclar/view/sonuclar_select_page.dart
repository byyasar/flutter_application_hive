import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/custom_appbar.dart';
import 'package:flutter_application_hive/core/widget/custom_ders_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button2.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_sinif_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/store/ogrenci_store.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/features/sonuclar/view/sonuclar_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert' as convert;
//import 'package:logger/logger.dart';
import 'package:flutter_application_hive/core/widget/build_drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SonuclarSelectPage extends StatefulWidget {
  const SonuclarSelectPage({Key? key}) : super(key: key);

  @override
  State<SonuclarSelectPage> createState() => _SonuclarSelectPageState();
}

class _SonuclarSelectPageState extends BaseState<SonuclarSelectPage> {
  final _viewModelSinif = SinifStore();
  final _viewModelDers = DersStore();
  //final _viewModelTemrin = TemrinStore();
  final _viewModelOgrenci = OgrenciStore();

  String _sinifSecText = "Sınıf Seç";
  String _dersSecText = "Ders Seç";
  //String _temrinSecText = "Temrin Seç";
  String _ogrenciSecText = "Öğrenci Seç";

  @override
  Widget build(BuildContext context) {
    /* _viewModelDers.setFiltreDersId(4);
    _viewModelSinif.setFiltreSinifId(2);
    _viewModelTemrin.setFiltretemrinId(1); */
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context),
        appBar: customAppBar(context, 'TNS-Not Listeleme'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset('assets/logo.jpeg'),
              const Text('Sınıf:', style: TextStyle(fontSize: 18)),
              _buildSinifSec(context),
              const Text('Ders:', style: TextStyle(fontSize: 18)),
              _buildDersSec(context),
              //const Text('Temrin:', style: TextStyle(fontSize: 18)),
              //_buildTemrinSec(context),
              const Text('Öğrenci:', style: TextStyle(fontSize: 18)),
              _buildOgrenciSec(context),
            ],
          ),
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return FloatingActionButton.extended(
                icon: IconsConstans.puanlarIcon,
                backgroundColor: _viewModelOgrenci.filtreOgrenciId == -1 ? Colors.grey : Colors.green,
                onPressed: _viewModelOgrenci.filtreOgrenciId == -1
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SonuclarViewPage(
                                  parametreler: [
                                    _viewModelSinif.filtreSinifId,
                                    _viewModelDers.filtredersId,
                                    _viewModelOgrenci.filtreOgrenciId,
                                    _viewModelOgrenci.ogrenciAd,
                                    _viewModelDers.dersAd
                                  ],
                                )));
                      },
                label: const Text('Öğrenci Notları Listele'));
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
    final dersModel = DersModel(id: id, dersad: dersad, sinifId: _viewModelSinif.filtreSinifId);
    final box = DersBoxes.getTransactions();
    box.add(dersModel);
  }

  /* _addTransactionTemrin(int id, String temrinKonusu, int dersId) async {
    final transaction = TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);
    final box = TemrinBoxes.getTransactions();
    box.add(transaction);
  } */

  _addTransactionOgrenci(int id, String name, int nu, int sinifId) {
    final ogrenciModel = OgrenciModel(id: id, name: name, nu: nu, sinifId: sinifId);
    final box = OgrenciBoxes.getTransactions();
    box.add(ogrenciModel);
  }

  _buildSinifSec(BuildContext context) => myCustomMenuButton(context, () {
        showDialog(context: context, builder: (context) => CustomSinifDialog(onClickedDone: _addTransactionSinif))
            .then((value) {
          _tumSecimleriSifirla();
          if (value != null) {
            _sinifSecText = value.sinifAd;
            _viewModelSinif.setFiltreSinifId(value.sinifId);
            if (value.sinifId == -1) {
              _sinifSecText = "Sınıf Seç";
              _tumSecimleriSifirla();
            }
            _viewModelSinif.setSinifAd(_sinifSecText);

            //Logger().i('Seçilen sınıf id ${value.sinifId} sınıf ${value.sinifAd}');
          }
        });
      },
          Observer(
              builder: (context) => Text(_viewModelSinif.sinifAd.isEmpty ? _sinifSecText : _viewModelSinif.sinifAd)),
          IconsConstans.sinifIcon,
          null);
  _buildDersSec(BuildContext context) => Observer(builder: (context) {
        return myCustomMenuButto2(
            context,
            _viewModelSinif.filtreSinifId == -1
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDersDialog(
                            gelensinifId: _viewModelSinif.filtreSinifId,
                            onClickedDone: _addTransactionDers)).then((value) {
                      //_temrinSecimiSifirla();
                      if (value != null) {
                        _dersSecText = value.dersAd;
                        _viewModelDers.setFiltreDersId(value.dersId);
                        if (value.dersId == -1) {
                          _dersSecText = "Ders Seç";
                        }
                        _viewModelDers.setDersAd(_dersSecText);
                        // Logger().i('Seçilen ders id ${value.dersId} ders: ${value.dersAd}');
                      }
                    });
                  },
            (_viewModelDers.dersAd.isEmpty ? _dersSecText : _viewModelDers.dersAd),
            IconsConstans.dersIcon,
            null,dyanmicWidth(.5));
      });
  _buildOgrenciSec(BuildContext context) => Observer(builder: (context) {
        return myCustomMenuButton(
            context,
            _viewModelDers.filtredersId == -1
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomOgrenciDialog(
                            gelenSinifId: _viewModelSinif.filtreSinifId,
                            onClickedDone: _addTransactionOgrenci)).then((value) {
                      if (value != null) {
                        _ogrenciSecText = value.ogrenciAd;
                        _viewModelOgrenci.setFiltreOgrenciId(value.ogrenciId);
                        if (value.ogrenciId == -1) {
                          _ogrenciSecText = "Öğrenci Seç";
                        }
                        _viewModelOgrenci.setOgrenciAd(_ogrenciSecText);
                        // Logger().i('Seçilen ogrenci id ${value.ogrenciAd} ');
                      }
                    });
                  },
            Text(_viewModelOgrenci.ogrenciAd.isEmpty ? _ogrenciSecText : _viewModelOgrenci.ogrenciAd),
            IconsConstans.ogrenciIcon,
            null);
      });
 

  void _tumSecimleriSifirla() {
    // Logger().i('tum secimler sıfırlandı');
    _dersSecimiSifirla();
    // _temrinSecimiSifirla();,
    _ogrenciSecimiSifirla();
  }

  void _dersSecimiSifirla() {
    //Logger().i('ders secimleri sıfırlandı');
    _viewModelDers.setFiltreDersId(-1);
    _dersSecText = "Ders Seç";
    _viewModelDers.setDersAd(_dersSecText);
  }

  void _ogrenciSecimiSifirla() {
    //Logger().i('ders secimleri sıfırlandı');
    _viewModelOgrenci.setFiltreOgrenciId(-1);
    _ogrenciSecText = "Öğrenci Seç";
    _viewModelOgrenci.setOgrenciAd(_ogrenciSecText);
  }

  /* void _temrinSecimiSifirla() {
    //Logger().i('temrin secimleri sıfırlandı');
    _viewModelTemrin.setFiltretemrinId(-1);
    _temrinSecText = "Temrin Seç";
    _viewModelTemrin.settemrinKonusu(_temrinSecText);
  } */

}
