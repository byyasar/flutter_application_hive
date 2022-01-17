import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/custom_ders_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_card.dart';
import 'package:flutter_application_hive/core/widget/custom_sinif_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_temrin_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/store/ogrenci_store.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/store/temrin_store.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TemrinnotpageView extends StatefulWidget {
  const TemrinnotpageView({Key? key}) : super(key: key);

  @override
  _TemrinnotpageViewState createState() => _TemrinnotpageViewState();
}

class _TemrinnotpageViewState extends BaseState<TemrinnotpageView> {
  List<TemrinModel> transactionsTemrin = [];
  List<OgrenciModel> transactionsOgrenci = [];
  List<SinifModel> transactionsSinif = [];
  List<DersModel> transactionsDers = [];
  List<TemrinnotModel> transactionsTemrinnot = [];

  //SinifStore sinifStore = SinifStore();
  SinifStore viewModelSinif = SinifStore();
  DersStore viewModelDers = DersStore();
  OgrenciStore ogrenciStore = OgrenciStore();
  TemrinStore viewModelTemrin = TemrinStore();
  List<OgrenciModel> transactionsOgrenciSinif = [];
  List<TextEditingController> _controllers = [];
  String sinifsecText = "Sınıf Seç";
  String derssecText = "Ders Seç";
  String temrinsecText = "Temrin Seç";
  List<int> secimler = [];
  @override
  void initState() {
    if (transactionsSinif.isEmpty) {
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
    secimler = [-1, -1, -1]; //sınıf-dersadı-temrinkonusu
    viewModelSinif.setFiltreSinifId(secimler[0]);
    viewModelDers.setFiltreDersId(secimler[1]);
    viewModelTemrin.setFiltretemrinId(secimler[2]);
    /* print(
        'viewModelTemrin.setFiltretemrinId(secimler[2]): $viewModelTemrin.setFiltretemrinId(secimler[2])');
 */
    super.initState();
  }

  @override
  void dispose() {
    //Hive.close();
    _controllers.clear();
    super.dispose();
  }

  void editTransactionTemrinnot(
    TemrinnotModel transaction,
    int id,
    int temrinId,
    int ogrenciId,
    int puan,
    String notlar,
  ) {
    transaction.id = id;
    transaction.temrinId = temrinId;
    transaction.ogrenciId = ogrenciId;
    transaction.puan = puan;
    transaction.notlar = notlar;
    transaction.save();
  }

  Future addTransactionTemrinnot(String key, int id, int temrinId,
      int ogrenciId, int puan, String notlar) async {
    final transaction = TemrinnotModel(
        id: id,
        temrinId: temrinId,
        ogrenciId: ogrenciId,
        puan: puan,
        notlar: notlar,
        gelmedi: false);
    final box = TemrinnotBoxes.getTransactions();
    box.put(key, transaction);
  }

  void editTransactionSinif(SinifModel transaction, int id, String sinifAd) {
    transaction.id = id;
    transaction.sinifAd = sinifAd;
    transaction.save();
  }

  void deleteTransactionSinif(SinifModel transaction) {
    transaction.delete();
  }

  void deleteTransactionTemrinnot(TemrinnotModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SinifStore>(
      viewModel: SinifStore(),
      onModelReady: (model) {
        viewModelSinif = model;
      },
      onPageBuilder: (context, value) => Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                heroTag: 'ekle',
                child: const Icon(Icons.add),
                onPressed: () async {
                  final Box<TemrinnotModel> _box =
                      TemrinnotBoxes.getTransactions();
                  //await _box.putAt(0, TemrinnotModel(id: 1, temrinId: 1, ogrenciId: 1, puan: 50, notlar: ''));
                  _box.put(
                      '1-1',
                      TemrinnotModel(
                          id: 1,
                          temrinId: 1,
                          ogrenciId: 1,
                          puan: 100,
                          notlar: '',
                          gelmedi: false));
                  _box.put(
                      '1-2',
                      TemrinnotModel(
                          id: 1,
                          temrinId: 1,
                          ogrenciId: 2,
                          puan: 80,
                          notlar: '',
                          gelmedi: true));
                  _box.put(
                      '1-3',
                      TemrinnotModel(
                          id: 1,
                          temrinId: 1,
                          ogrenciId: 3,
                          puan: 90,
                          notlar: '',
                          gelmedi: false));
                  _box.put(
                      '1-4',
                      TemrinnotModel(
                          id: 1,
                          temrinId: 1,
                          ogrenciId: 4,
                          puan: 70,
                          notlar: '',
                          gelmedi: false));
                  /* print('key:' +
                        _box.values.last.key.toString() +
                        '-temrinId:' +
                        _box.values.last.temrinId.toString() +
                        '-ogrenciId:' +
                        _box.values.last.ogrenciId.toString() +
                        '-puan:' +
                        _box.values.last.puan.toString()); */
                  // print(_box.get('1-1')!.puan.toString());
                }),
            FloatingActionButton(
                heroTag: 'sil',
                child: const Icon(Icons.delete),
                onPressed: () async {
                  final Box<TemrinnotModel> _box =
                      TemrinnotBoxes.getTransactions();
                  await _box.clear();
                }),
          ],
        ),
        appBar: AppBar(
          title: const Text('Temrinnot Listesi'),
          centerTitle: true,
        ),
        body: Observer(
          builder: (context) => Container(
            color: Colors.amber,
            child: Column(children: [
              Container(
                color: Colors.amber.shade200,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //print(viewModel.sinifAd);
                      Column(
                        children: [
                          const Text(
                            "Sınıf Adı",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                      context: context,
                                      builder: (context) => CustomSinifDialog(
                                          onClickedDone: addTransactionSinif))
                                  .then((value) {
                                if (value != null) {
                                  //sonSecilenFiltreSinifId = viewModelSinif.filtreSinifId;

                                  viewModelSinif.sinifAd = value.sinifAd;
                                  viewModelSinif.filtreSinifId = value.sinifId;
                                  //print('Secimler :$secimler');
                                  secimler[0] = value.sinifId;
                                }
                              });
                            },
                            child: Text(viewModelSinif.sinifAd.isEmpty
                                ? sinifsecText
                                : viewModelSinif.sinifAd),
                          ),
                        ],
                      ),
                      Visibility(
                        //DERS SEÇ BUTON
                        visible:
                            viewModelSinif.filtreSinifId != -1 ? true : false,
                        //visible: true,
                        child: Column(
                          children: [
                            const Text(
                              "Ders Adı",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                        context: context,
                                        builder: (context) => CustomDersDialog(
                                            gelensinifId:
                                                viewModelSinif.filtreSinifId,
                                            onClickedDone: addTransactionDers))
                                    .then((value) {
                                  if (value != null) {
                                    viewModelDers.dersAd = value.dersAd;
                                    viewModelDers.filtredersId = value.dersId;
                                    //sonSecilenFiltreSinifId = viewModelSinif.filtreSinifId;
                                    //viewModelTemrin.setFiltretemrinId(-1);
                                    secimler[1] = value.dersId;
                                  }
                                });
                              },
                              child: Text(viewModelDers.dersAd
                                      .isEmpty /* || sonSecilenFiltreSinifId != viewModelSinif.filtreSinifId */
                                  ? derssecText
                                  : viewModelDers.dersAd.length < 8
                                      ? viewModelDers.dersAd
                                      : viewModelDers.dersAd.substring(0, 8)),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        //TEMRİN SEÇ BUTON
                        visible:
                            viewModelDers.filtredersId != -1 ? true : false,
                        child: Column(
                          children: [
                            const Text(
                              "Temrin Konusu",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CustomTemrinDialog(
                                        gelenDersId: viewModelDers.filtredersId,
                                        onClickedDone:
                                            addTransactionDers)).then((value) {
                                  if (value != null) {
                                    viewModelTemrin.temrinKonusu =
                                        value.temrinKonusu;
                                    viewModelTemrin.filtretemrinId =
                                        value.filtretemrinId;
                                    secimler[2] = value.filtretemrinId;
                                    // = viewModelDers.filtredersId;
                                    //sonSecilenFitreTemrinId = viewModelTemrin.filtretemrinId; //ANCHOR:TEMRİN DEĞİŞTİRME
                                  }
                                });
                              },
                              child: Text(viewModelTemrin.temrinKonusu
                                      .isEmpty /* ||
                                    sonSecilenFiltreSinifId != viewModelSinif.filtreSinifId ||
                                    sonSecilenFiltreDersId != viewModelDers.filtredersId */
                                  ? temrinsecText
                                  : viewModelTemrin.temrinKonusu.length < 18
                                      ? viewModelTemrin.temrinKonusu
                                      : viewModelTemrin.temrinKonusu
                                          .substring(0, 18)),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              const Divider(height: 10, color: Colors.redAccent),
              const SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.blueAccent,
                child: Visibility(
                  visible: viewModelTemrin.filtretemrinId != -1 ? true : false,
                  child: Column(
                    children: [
                      //const Text('Öğrenci Listesi'),
                      SizedBox(
                        height: dynamicHeight(.6),
                        child: viewModelTemrin.filtretemrinId != -1
                            ? FutureBuilder(
                                future: TemrinnotListesiHelper(
                                        ApplicationConstants.boxTemrinNot)
                                    .temrinnotFiltreListesiGetir(
                                        viewModelTemrin.filtretemrinId),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return buildOgrenciListesi(
                                        context,
                                        viewModelSinif.filtreSinifId,
                                        snapshot.data);
                                  } else {
                                    return const Text("Datayok");
                                  }
                                })
                            : const Text('Öğrenci Listesi'),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: viewModelDers.filtredersId == -1 ||
                          viewModelTemrin.filtretemrinId == -1
                      ? null
                      : () async {
                          //ANCHOR: NOT KAYDET
                          //print('kaydet${_controllers.length}');
                          for (var item in _controllers) {
                            //print(_controllers.indexOf(item));
                            //print(transactionsOgrenciSinif[_controllers.indexOf(item)].name + " Not:" + item.text);
                            String _key =
                                viewModelTemrin.filtretemrinId.toString() +
                                    '-' +
                                    transactionsOgrenciSinif[
                                            _controllers.indexOf(item)]
                                        .id
                                        .toString();
                            await addTransactionTemrinnot(
                                _key,
                                1,
                                viewModelTemrin.filtretemrinId,
                                transactionsOgrenciSinif[
                                        _controllers.indexOf(item)]
                                    .id,
                                int.parse(item.text.isEmpty ? "0" : item.text),
                                '');
                          }
                        },
                  child: const Text('Kaydet', style: TextStyle(fontSize: 22))),
              const Divider(height: 10, color: Colors.redAccent),
              Container(
                height: dynamicHeight(.1),
                color: Colors.blueGrey.shade400,
                child: Visibility(
                  visible: viewModelTemrin.filtretemrinId != -1 ? true : false,
                  child: viewModelTemrin.filtretemrinId != -1
                      ? FutureBuilder(
                          future: TemrinnotListesiHelper('temrinnot')
                              .temrinnotFiltreListesiGetir(viewModelTemrin
                                  .filtretemrinId), //temrinnotlariListe(context, viewModelTemrin.filtretemrinId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return temrinnotlariListe(context, snapshot.data);
                            } else {
                              return const Text("Datayok");
                            }
                          },
                        )
                      : const Text(""),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  addTransactionSinif(int id, String sinifAd) async {
    final transaction = SinifModel(id: id, sinifAd: sinifAd);
    final box = SinifBoxes.getTransactions();
    box.add(transaction);
  }

  addTransactionDers(int id, String dersAd, int sinifId) {
    final transaction = DersModel(id: id, sinifId: sinifId, dersad: dersAd);
    final box = DersBoxes.getTransactions();
    box.add(transaction);
  }

  addTransactionTemrin(int id, String temrinKonusu, int dersId) {
    final transaction =
        TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);
    final box = TemrinBoxes.getTransactions();
    box.add(transaction);
  }

  buildOgrenciListesi(BuildContext context, int filtreSinifId,
      List<TemrinnotModel> temrinnotModelList) {
    List filtretemrinList = [];
    filtretemrinList = temrinnotModelList;
    if (transactionsOgrenci.isEmpty) {
      transactionsOgrenci =
          OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
    }
    //List<OgrenciModel> transactionsOgrenciSinif = [];
    transactionsOgrenciSinif = [];
    transactionsOgrenciSinif =
        OgrenciListesiHelper(ApplicationConstants.boxOgrenci)
            .getFilteredValues('SinifId', viewModelSinif.filtreSinifId)!;
    //print(transactionsOgrenciSinif.length);
    _controllers = [];
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: transactionsOgrenciSinif.length,
      itemBuilder: (BuildContext context, int index) {
        _controllers.add(TextEditingController());
        final transaction = transactionsOgrenciSinif[index];
        //print('öğrenci bilgisi id: ${transaction.id}');
        //print('temrin bilgisi id: ${filtretemrinList.length}');
        for (TemrinnotModel temrinnot in filtretemrinList) {
          if (temrinnot.ogrenciId == transaction.id) {
            _controllers[index].text = temrinnot.puan.toString();
          }
        }
      return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          controller: _controllers[index],
        );
      },
    );
  }

  temrinnotlariListe(
      BuildContext context, List<TemrinnotModel> temrinnotModelList) {
    List filtretemrinList = [];
    filtretemrinList = temrinnotModelList;
    /*  transactionsTemrinnot = TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
    for (var temrinnot in transactionsTemrinnot) {
      temrinnot.temrinId == filtretemdrinId ? filtretemrinId.add(temrinnot) : "";
    } */
    //filtretemrinList = await TemrinnotListesiHelper().temrinnotFiltreListesiGetir(filtreTemrinId);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: filtretemrinList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("temrin not id" +
                filtretemrinList[index].id.toString() +
                "-ogrid: " +
                filtretemrinList[index].ogrenciId.toString() +
                "-temrin id " +
                filtretemrinList[index].temrinId.toString() +
                "-puan " +
                filtretemrinList[index].puan.toString()),
          );
        });
  }
}
