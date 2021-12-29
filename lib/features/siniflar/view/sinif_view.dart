import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/siniflar/dialog/sinif_dialog.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/widget/sinif_card.dart';

import 'package:hive_flutter/hive_flutter.dart';

class SinifpageView extends StatefulWidget {
  const SinifpageView({Key? key}) : super(key: key);

  @override
  _SinifpageViewState createState() => _SinifpageViewState();
}

class _SinifpageViewState extends State<SinifpageView> {
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  void editTransaction(
    SinifModel transaction,
    int id,
    String sinifAd,
  ) {
    transaction.id = id;
    transaction.sinifAd = sinifAd;
    transaction.save();
  }

  void deleteTransaction(SinifModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Sınıf Listesi'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<SinifModel>>(
          valueListenable: SinifBoxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<SinifModel>();
            // ignore: avoid_print
            print(transactions.length);
            //return Text(transactions[1].detail);
            return buildContent(transactions);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SinifDialog(
                onClickedDone: addTransaction,
              ),
            ),
          ),
        ),
      );

  Widget buildContent(List<SinifModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'Henüz Sinif yok!',
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

  Widget buildTransaction(BuildContext context, SinifModel transaction, int index) {
    return SinifCard(transaction: transaction, index: index, butons: buildButtons(context, transaction));
  }

  Future addTransaction(int id, String sinifAd) async {
    final transaction = SinifModel(id: id, sinifAd: sinifAd);

    final box = SinifBoxes.getTransactions();
    box.add(transaction);
  }

  Widget buildButtons(BuildContext context, SinifModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SinifDialog(
                    transaction: transaction,
                    onClickedDone: (id, sinifAd) => editTransaction(transaction, id, sinifAd),
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
