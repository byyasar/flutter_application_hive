import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/build_drawer.dart';
import 'package:flutter_application_hive/core/widget/custom_appbar.dart';
import 'package:flutter_application_hive/core/widget/custom_ders_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/core/widget/custom_sinif_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_temrin_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/store/temrin_store.dart';
import 'package:flutter_application_hive/features/temrinnot/view/temrinnot_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logger/logger.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
  /* List<SinifModel> _transactionsSinif = [];
  List<DersModel> _transactionsDers = [];
  List<TemrinModel> _transactionsTemrin = []; */

  final _viewModelSinif = SinifStore();
  final _viewModelDers = DersStore();
  final _viewModelTemrin = TemrinStore();

  String _sinifSecText = "Sınıf Seç";
  String _dersSecText = "Ders Seç";
  String _temrinSecText = "Temrin Seç";

  //final DersListesiHelper _dersListesiHelper = DersListesiHelper(ApplicationConstants.boxDers);

  @override
  Widget build(BuildContext context) {
    /* _viewModelDers.setFiltreDersId(4);
    _viewModelSinif.setFiltreSinifId(2);
    _viewModelTemrin.setFiltretemrinId(1); */
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context),
        appBar: customAppBar(context, 'TNS-Temrin Seçimi'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sınıf:', style: TextStyle(fontSize: 18)),
              _buildSinifSec(context),
              const Text('Ders:', style: TextStyle(fontSize: 18)),
              _buildDersSec(context),
              const Text('Temrin:', style: TextStyle(fontSize: 18)),
              _buildTemrinSec(context),
            ],
          ),
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return FloatingActionButton.extended(
                icon: const Icon(Icons.add_chart_rounded),
                backgroundColor: _viewModelTemrin.filtretemrinId == -1 ? Colors.grey : Colors.green,
                onPressed: _viewModelTemrin.filtretemrinId == -1
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TemrinNotViewPage(
                                  parametreler: [
                                    _viewModelSinif.filtreSinifId,
                                    _viewModelDers.filtredersId,
                                    _viewModelTemrin.filtretemrinId
                                  ],
                                )));
                      },
                label: const Text('Temrin Not Gir'));
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

  _addTransactionTemrin(int id, String temrinKonusu, int dersId) async {
    final transaction = TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);
    final box = TemrinBoxes.getTransactions();
    box.add(transaction);
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

            Logger().i('Seçilen sınıf id ${value.sinifId} sınıf ${value.sinifAd}');
          }
        });
      },
          Observer(
              builder: (context) => Text(_viewModelSinif.sinifAd.isEmpty ? _sinifSecText : _viewModelSinif.sinifAd)),
          const Icon(Icons.class__outlined),
          null);
  _buildDersSec(BuildContext context) => Observer(builder: (context) {
        return myCustomMenuButton(
            context,
            _viewModelSinif.filtreSinifId == -1
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDersDialog(
                            gelensinifId: _viewModelSinif.filtreSinifId,
                            onClickedDone: _addTransactionDers)).then((value) {
                      _temrinSecimiSifirla();
                      if (value != null) {
                        _dersSecText = value.dersAd;
                        _viewModelDers.setFiltreDersId(value.dersId);
                        if (value.dersId == -1) {
                          _dersSecText = "Ders Seç";
                        }
                        _viewModelDers.setDersAd(_dersSecText);
                        Logger().i('Seçilen ders id ${value.dersId} ders: ${value.dersAd}');
                      }
                    });
                  },
            Text(_viewModelDers.dersAd.isEmpty ? _dersSecText : _viewModelDers.dersAd),
            const Icon(Icons.class__outlined),
            null);
      });
  _buildTemrinSec(BuildContext context) => Observer(builder: (context) {
        return myCustomMenuButton(
            context,
            _viewModelDers.filtredersId == -1
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomTemrinDialog(
                            gelenDersId: _viewModelDers.filtredersId,
                            onClickedDone: _addTransactionTemrin)).then((value) {
                      if (value != null) {
                        _temrinSecText = value.temrinKonusu;
                        _viewModelTemrin.setFiltretemrinId(value.temrinId);
                        if (value.temrinId == -1) {
                          _temrinSecText = "Temrin Seç";
                        }
                        _viewModelTemrin.settemrinKonusu(_temrinSecText);
                        Logger().i('Seçilen temrin id ${value.temrinId} temrin konusu: ${value.temrinKonusu}');
                      }
                    });
                  },
            Text(_viewModelTemrin.temrinKonusu.isEmpty ? _temrinSecText : _viewModelTemrin.temrinKonusu),
            const Icon(Icons.class__outlined),
            null);
      });

  void _tumSecimleriSifirla() {
    Logger().i('tum secimler sıfırlandı');
    _dersSecimiSifirla();
    _temrinSecimiSifirla();
  }

  void _dersSecimiSifirla() {
    Logger().i('ders secimleri sıfırlandı');
    _viewModelDers.setFiltreDersId(-1);
    _dersSecText = "Ders Seç";
    _viewModelDers.setDersAd(_dersSecText);
  }

  void _temrinSecimiSifirla() {
    Logger().i('temrin secimleri sıfırlandı');
    _viewModelTemrin.setFiltretemrinId(-1);
    _temrinSecText = "Temrin Seç";
    _viewModelTemrin.settemrinKonusu(_temrinSecText);
  }
}
