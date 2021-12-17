import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/dersler/dialog/ders_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/widget/ders_card.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DerspageView extends StatefulWidget {
  const DerspageView({Key? key}) : super(key: key);

  @override
  _DerspageViewState createState() => _DerspageViewState();
}

class _DerspageViewState extends State<DerspageView> {
  SinifStore sinifStore = SinifStore();
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  void editTransaction(
    DersModel transaction,
    int id,
    String dersad,
    int sinifId,
  ) {
    transaction.id = id;
    transaction.dersad = dersad;
    transaction.sinifId = sinifId;
    transaction.save();
  }

  void deleteTransaction(DersModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ders Listesi'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onCanceled: () => sinifStore.setFiltreSinifId(-1),
              onSelected: (value) {
                //print(value);
                sinifStore.setFiltreSinifId(int.parse(value));
              },
              itemBuilder: (BuildContext context) {
                return SinifBoxes.getTransactions()
                    .values
                    .toList()
                    .cast<SinifModel>()
                    .map((e) {
                  return PopupMenuItem(
                    value: e.id.toString(),
                    child: Text(e.sinifAd),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Observer(builder: (_) {
          int filtre = sinifStore.filtreSinifId;
          //print("filtre: ${sinifStore.filtreSinifId}");
          return ValueListenableBuilder<Box<DersModel>>(
              valueListenable: DersBoxes.getTransactions().listenable(),
              builder: (context, box, _) {
                List<DersModel> transactions = [];
                if (filtre != -1) {
                  transactions = box.values
                      .where((object) =>
                          object.sinifId == filtre)
                      .toList();
                } else {
                  transactions = box.values.toList().cast<DersModel>();
                }
                // ignore: avoid_print
                print(transactions.length);
                //return Text(transactions[1].detail);
                return buildContent(transactions);
              });
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => DersDialog(
                onClickedDone: addTransaction,
              ),
            ),
          ),
        ),
      );

  Widget buildContent(List<DersModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'Henüz ders yok!',
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
      BuildContext context, DersModel transaction, int index) {
    return DersCard(
        transaction: transaction,
        index: index,
        butons: buildButtons(context, transaction));
  }

  Future addTransaction(int id, String dersad, int sinifId) async {
    final transaction = DersModel(id: id, dersad: dersad, sinifId: sinifId);

    final box = DersBoxes.getTransactions();
    box.add(transaction);
  }

  Widget buildButtons(BuildContext context, DersModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DersDialog(
                    transaction: transaction,
                    onClickedDone: (id, dersad, sinifId) =>
                        editTransaction(transaction, id, dersad, sinifId),
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
      );
}