import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/custom_ders_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_card.dart';
import 'package:flutter_application_hive/core/widget/custom_sinif_dialog.dart';
import 'package:flutter_application_hive/core/widget/custom_temrin_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/store/ogrenci_store.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/store/temrin_store.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  @override
  void initState() {
    if (transactionsSinif.isEmpty) {
      transactionsSinif = SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }

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

  Future addTransactionTemrinnot(int id, int temrinId, int ogrenciId, int puan, String notlar) async {
    final transaction = TemrinnotModel(id: id, temrinId: temrinId, ogrenciId: ogrenciId, puan: puan, notlar: notlar);
    final box = TemrinnotBoxes.getTransactions();
    box.add(transaction);
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
    List<int> secimler = [1, 1, 1]; //sınıf-dersadı-temrinkonusu
    viewModelSinif.setFiltreSinifId(secimler[0]);
    viewModelDers.setFiltreDersId(secimler[1]);
    viewModelTemrin.setFiltretemrinId(secimler[2]);

    //print("${viewModelSinif.filtreSinifId} - ${viewModelDers.filtredersId} -  ${viewModelTemrin.filtretemrinId}");

    //int sonSecilenFiltreSinifId = -1;
    // int sonSecilenFiltreDersId = -1;
    // int sonSecilenFitreTemrinId = -1;

    String sinifsecText = "Sınıf Seç";
    String derssecText = "Ders Seç";
    String temrinsecText = "Temrin Seç";

    return BaseView<SinifStore>(
      viewModel: SinifStore(),
      onModelReady: (model) {
        viewModelSinif = model;
      },
      onPageBuilder: (context, value) => Scaffold(
        appBar: AppBar(
          title: const Text('Temrinnot Listesi'),
          centerTitle: true,
        ),
        body: Observer(
          builder: (context) => Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //print(viewModel.sinifAd);
              Column(
                children: [
                  const Text(
                    "Sınıf Adı",
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => CustomSinifDialog(onClickedDone: addTransactionSinif)).then((value) {
                        if (value != null) {
                          //sonSecilenFiltreSinifId = viewModelSinif.filtreSinifId;

                          viewModelSinif.sinifAd = value.sinifAd;
                          viewModelSinif.filtreSinifId = value.sinifId;
                          //print('Secimler :$secimler');
                        }
                      });
                    },
                    child: Text(viewModelSinif.sinifAd.isEmpty ? sinifsecText : viewModelSinif.sinifAd),
                  ),
                ],
              ),
              Visibility(
                //DERS SEÇ BUTON
                visible: viewModelSinif.filtreSinifId != -1 ? true : false,
                //visible: true,
                child: Column(
                  children: [
                    const Text(
                      "Ders Adı",
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomDersDialog(
                                gelensinifId: viewModelSinif.filtreSinifId,
                                onClickedDone: addTransactionDers)).then((value) {
                          if (value != null) {
                            viewModelDers.dersAd = value.dersAd;
                            viewModelDers.filtredersId = value.dersId;
                            //sonSecilenFiltreSinifId = viewModelSinif.filtreSinifId;
                            //viewModelTemrin.setFiltretemrinId(-1);
                          }
                        });
                      },
                      child: Text(
                          viewModelDers.dersAd.isEmpty /* || sonSecilenFiltreSinifId != viewModelSinif.filtreSinifId */
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
                visible: viewModelDers.filtredersId != -1 ? true : false,
                child: Column(
                  children: [
                    const Text(
                      "Temrin Konusu",
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomTemrinDialog(
                                gelenDersId: viewModelDers.filtredersId,
                                onClickedDone: addTransactionDers)).then((value) {
                          if (value != null) {
                            viewModelTemrin.temrinKonusu = value.temrinKonusu;
                            viewModelTemrin.filtretemrinId = value.filtretemrinId;
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
                              : viewModelTemrin.temrinKonusu.substring(0, 18)),
                    ),
                  ],
                ),
              ),
            ]),
            const Divider(height: 10, color: Colors.redAccent),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: viewModelTemrin.filtretemrinId != -1 ? true : false,
              child: Column(
                children: [
                  //const Text('Öğrenci Listesi'),
                  Container(
                    child: viewModelTemrin.filtretemrinId != -1
                        ? FutureBuilder(
                            future: TemrinnotListesiHelper('temrinnot')
                                .temrinnotFiltreListesiGetir(viewModelTemrin.filtretemrinId),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return buildOgrenciListesi(context, viewModelSinif.filtreSinifId, snapshot.data);
                              } else {
                                return const Text("Datayok");
                              }
                            })
                        : const Text('Öğrenci Listesi'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: viewModelDers.filtredersId == -1 || viewModelTemrin.filtretemrinId == -1
                    ? null
                    : () async {
                        //ANCHOR: NOT KAYDET
                        //print('kaydet${_controllers.length}');
                        for (var item in _controllers) {
                          //print(_controllers.indexOf(item));
                          //print(transactionsOgrenciSinif[_controllers.indexOf(item)].name + " Not:" + item.text);
                          await addTransactionTemrinnot(
                              1,
                              viewModelTemrin.filtretemrinId,
                              transactionsOgrenciSinif[_controllers.indexOf(item)].id,
                              int.parse(item.text.isEmpty ? "0" : item.text),
                              '');
                        }
                      },
                child: const Text('Kaydet', style: TextStyle(fontSize: 22))),
            const Divider(height: 10, color: Colors.redAccent),
            Visibility(
              visible: viewModelTemrin.filtretemrinId != -1 ? true : false,
              child: Expanded(
                child: viewModelTemrin.filtretemrinId != -1
                    ? FutureBuilder(
                        future: TemrinnotListesiHelper('temrinnot').temrinnotFiltreListesiGetir(viewModelTemrin
                            .filtretemrinId), //temrinnotlariListe(context, viewModelTemrin.filtretemrinId),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
    final transaction = TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);
    final box = TemrinBoxes.getTransactions();
    box.add(transaction);
  }

  buildOgrenciListesi(BuildContext context, int filtreSinifId, List<TemrinnotModel> temrinnotModelList) {
    List filtretemrinList = [];
    filtretemrinList = temrinnotModelList;
    if (transactionsOgrenci.isEmpty) {
      transactionsOgrenci = OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
    }
    //List<OgrenciModel> transactionsOgrenciSinif = [];
    transactionsOgrenciSinif = [];

    // transactionsOgrenciSinif = TemrinnotListesiHelper().getFilteredValues("sinifId", filtreSinifId);
    /* 
    for (var ogrenci in transactionsOgrenci) {
      if (ogrenci.sinifId == filtreSinifId) {
        transactionsOgrenciSinif.add(ogrenci);
      }
    } */
    _controllers = [];
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: transactionsOgrenciSinif.length,
      itemBuilder: (BuildContext context, int index) {
        _controllers.add(TextEditingController());
        final transaction = transactionsOgrenciSinif[index];

        _controllers[index].text = filtretemrinList.isNotEmpty ? filtretemrinList[index].puan.toString() : "0";
        //return Text("${transaction.name}");
        return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          controller: _controllers[index],
        );
      },
    );
  }

  temrinnotlariListe(BuildContext context, List<TemrinnotModel> temrinnotModelList) {
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
