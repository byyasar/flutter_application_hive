import 'package:flutter/material.dart';
import 'package:flutter_application_hive/ogrenci/dialog/ogrenci_dialog.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/transaction_dialog.dart';
import 'package:flutter_application_hive/ui/widget/ogrenci_card.dart';
import 'package:flutter_application_hive/view/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OgrencipageView extends StatefulWidget {
  const OgrencipageView({Key? key}) : super(key: key);

  @override
  _OgrencipageViewState createState() => _OgrencipageViewState();
}

class _OgrencipageViewState extends State<OgrencipageView> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void editTransaction(
    OgrenciModel transaction,
    int id,
    String name,
    int nu,
  ) {
    transaction.id = id;
    transaction.name = name;
    transaction.nu = nu;
    transaction.save();
  }

  void deleteTransaction(OgrenciModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Öğrenci Listesi'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<OgrenciModel>>(
          valueListenable: OgrenciBoxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<OgrenciModel>();
            print(transactions.length);
            //return Text(transactions[1].detail);
            return buildContent(transactions);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => OgrenciDialog(
              onClickedDone: addTransaction,
            ),
          ),
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

  Future addTransaction(int id, String name, int nu) async {
    final transaction = OgrenciModel(id: id, name: name, nu: nu);

    final box = OgrenciBoxes.getTransactions();
    box.add(transaction);
  }

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
                    onClickedDone: (id, name, nu) =>
                        editTransaction(transaction, id, name, nu),
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
