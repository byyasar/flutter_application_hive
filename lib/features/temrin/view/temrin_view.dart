import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/temrin/dialog/temrin_dialog.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/widget/temrin_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TemrinpageView extends StatefulWidget {
  const TemrinpageView({Key? key}) : super(key: key);

  @override
  _TemrinpageViewState createState() => _TemrinpageViewState();
}

class _TemrinpageViewState extends State<TemrinpageView> {
  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  void editTransaction(
      TemrinModel transaction, int id, String temrinKonusu, int dersId) {
    transaction.id = id;
    transaction.temrinKonusu = temrinKonusu;
    transaction.dersId = dersId;
    transaction.save();
  }

  void deleteTransaction(TemrinModel transaction) {
    transaction.delete();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Temrin Listesi'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<TemrinModel>>(
          valueListenable: TemrinBoxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<TemrinModel>();
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => TemrinDialog(
                onClickedDone: addTransaction,
              ),
            ),
          ),
        ),
      );

  Widget buildContent(List<TemrinModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'Henüz Temrin yok!',
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
      BuildContext context, TemrinModel transaction, int index) {
    return TemrinCard(
        transaction: transaction,
        index: index,
        butons: buildButtons(context, transaction));
  }

  Future addTransaction(int id, String temrinKonusu, int dersId) async {
    final transaction =
        TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);

    final box = TemrinBoxes.getTransactions();
    box.add(transaction);
  }
//ANCHOR: Yeniden düzenlenecek

  Widget buildButtons(BuildContext context, TemrinModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TemrinDialog(
                    transaction: transaction,
                    onClickedDone: (id, temrinKonusu, dersId) =>
                        editTransaction(transaction, id, temrinKonusu, dersId),
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
