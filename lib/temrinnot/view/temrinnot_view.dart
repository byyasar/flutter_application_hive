import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/ogrenci/dialog/ogrenci_dialog.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/ogrenci/store/ogrenci_store.dart';
import 'package:flutter_application_hive/ogrenci/widget/ogrenci_card.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/siniflar/store/sinif_store.dart';
import 'package:flutter_application_hive/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/temrin/store/temrin_store.dart';
import 'package:flutter_application_hive/temrinnot/dialog/temrinnot_dialog.dart';
import 'package:flutter_application_hive/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TemrinnotpageView extends StatefulWidget {
  const TemrinnotpageView({Key? key}) : super(key: key);

  @override
  _TemrinnotpageViewState createState() => _TemrinnotpageViewState();
}

class _TemrinnotpageViewState extends State<TemrinnotpageView> {
  List<TemrinModel> transactionsTemrin = [];
  List<OgrenciModel> transactionsOgrenci = [];
  List<SinifModel> transactionsSinif = [];
  List<DersModel> transactionsDers = [];

  SinifStore sinifStore = SinifStore();
  DersStore dersStore = DersStore();
  OgrenciStore ogrenciStore = OgrenciStore();
  TemrinStore temrinStore = TemrinStore();

  int filtreSinifId = -1;
  String secim = "";

  @override
  void initState() {
    if (transactionsSinif.isEmpty) {
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
    if (transactionsTemrin.isEmpty) {
      transactionsTemrin =
          TemrinBoxes.getTransactions().values.toList().cast<TemrinModel>();
    }
    if (transactionsOgrenci.isEmpty) {
      transactionsOgrenci =
          OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
    }
    if (transactionsDers.isEmpty) {
      transactionsDers =
          DersBoxes.getTransactions().values.toList().cast<DersModel>();
    }
    super.initState();
  }

  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  void editTransaction(
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

  void deleteTransaction(TemrinnotModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Temrinnot Listesi'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildSinifListesi(transactionsSinif),
                      Observer(builder: (_) {
                        print(sinifStore.filtreSinifId);

                        return Visibility(
                          visible: filtreSinifId != -1 ? true : false,
                          child: filtreSinifId != -1
                              ? buildDersListesi(
                                  context, transactionsDers, filtreSinifId)
                              : Text(''),
                        );
                      }),
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: Observer(builder: (_) {
                print(sinifStore.filtreSinifId);
                filtreSinifId = sinifStore.filtreSinifId;
                return ValueListenableBuilder<Box<OgrenciModel>>(
                  valueListenable: OgrenciBoxes.getTransactions().listenable(),
                  builder: (context, box, _) {
                    List<OgrenciModel> transactions = [];

                    if (filtreSinifId != -1) {
                      transactions = box.values
                          .where((object) => object.sinifId == filtreSinifId)
                          .toList();
                    } else {
                      transactions = box.values.toList().cast<OgrenciModel>();
                    }
                    // ignore: avoid_print
                    print(transactions.length);
                    //return Text(transactions[1].detail);
                    return buildContent(transactions);
                  },
                );
              }),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => TemrinnotDialog(
                onClickedDone: addTransaction,
              ),
            ),
          ),
        ),
      );

  Widget buildSinifListesi(List<SinifModel> transactionsSinif) => SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          //label: "Sınıflar",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int sinifid = transactionsSinif
                .singleWhere((element) => element.sinifAd == value)
                .id;
            sinifStore.setFiltreSinifId(sinifid);
            //print('storedan glen id' + sinifStore.sinifId.toString());
          },
          selectedItem: sinifStore.sinifAd,
        ),
      );

  Widget buildContent(List<OgrenciModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'Henüz öğrenci yok!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      //return Text(transactions.length.toString());
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = transactions[index];

                return buildTransaction(context, transaction, index);
                //return Text(transactions.length.toString());
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    }
  }

  Widget buildTransaction(
      BuildContext context, OgrenciModel transaction, int index) {
    return OgrenciCard(
        transaction: transaction,
        index: index,
        butons: buildButtons(context, transaction));
  }

  Future addTransaction(
    int id,
    int temrinId,
    int ogrenciId,
    int puan,
    String notlar,
  ) async {
    final transaction = TemrinnotModel(
        id: id,
        temrinId: temrinId,
        ogrenciId: ogrenciId,
        puan: puan,
        notlar: notlar);

    final box = TemrinnotBoxes.getTransactions();
    box.add(transaction);
  }

  /*  Widget buildButtons(BuildContext context, TemrinnotModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TemrinnotDialog(
                    transaction: transaction,
                    onClickedDone: (id, temrinId, ogrenciId, puan, notlar) =>
                        editTransaction(
                            transaction, id, temrinId, ogrenciId, puan, notlar),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Sil'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(transaction),
            ),
          )
        ],
      ); */
  Widget buildButtons(BuildContext context, OgrenciModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OgrenciDialog(
                      transaction: transaction,
                      onClickedDone: (id, name, nu, sinifId) {}
                      // editTransaction(transaction, id, name, nu, sinifId),
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
                label: const Text('Sil'),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {} //=> deleteTransaction(transaction),
                ),
          )
        ],
      );
  List<String> buildItems() {
    List<String> items = SinifBoxes.getTransactions()
        .values
        .map((e) => e.sinifAd.toString())
        .toList();
    return items;
  }

  Widget buildDersListesi(BuildContext context,
      List<DersModel> transactionsDers, int filtreSinifId) {
    print('build ders çalıştı');
    List<DersModel> transactions = [];
    secim = "Ders seçiniz";
    if (filtreSinifId != -1) {
      transactions = transactionsDers
          .where((object) => object.sinifId == filtreSinifId)
          .toList();
    } else {
      transactions = transactionsDers;
    }

    return Observer(builder: (_) {
      print(dersStore.dersAd);
      secim = "Ders seçiniz";
      return SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItemsDers(transactions),
          //label: "Sınıflar",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int dersId = transactions
                .singleWhere((element) => element.dersad == value)
                .id;
            dersStore.setFiltreDersId(dersId);
            dersStore.setDersAd(value!);
            secim = value;
            //print('storedan glen id' + sinifStore.sinifId.toString());
          },
          //showSelectedItems: true,
          selectedItem: secim,
        ),
      );
    });
  }

  List<String> buildItemsDers(List<DersModel> transactions) {
    List<String> items = [];
    for (var element in transactions) {
      items.add(element.dersad);
    }
    return items;
  }
}
