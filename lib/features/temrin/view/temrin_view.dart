import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/exitapp_dialog.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/helper/temrin_listesi_helper.dart';
import 'package:flutter_application_hive/features/temrin/dialog/temrin_dialog.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/widget/temrin_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TemrinpageView extends StatefulWidget {
  const TemrinpageView({Key? key}) : super(key: key);

  @override
  _TemrinpageViewState createState() => _TemrinpageViewState();
}

class _TemrinpageViewState extends State<TemrinpageView> {
  final DersStore _viewDersModel = DersStore();
  final Box<TemrinModel> _box = TemrinBoxes.getTransactions();
  final TemrinListesiHelper _temrinListesiHelper = TemrinListesiHelper(ApplicationConstants.boxTemrin);

  @override
  void dispose() {
    //Hive.close();
    super.dispose();
  }

  void editTransaction(TemrinModel temrinModel, int id, String temrinKonusu, int dersId) {
    temrinModel.id = id;
    temrinModel.temrinKonusu = temrinKonusu;
    temrinModel.dersId = dersId;
    _temrinListesiHelper.addItem(temrinModel);
  }

  void deleteTransaction(TemrinModel temrinModel) {
    _temrinListesiHelper.deleteItem(temrinModel);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  Observer _buildBody() {
    return Observer(builder: (_) {
      int filtre = _viewDersModel.filtredersId;
      return ValueListenableBuilder<Box<TemrinModel>>(
        valueListenable: _box.listenable(),
        builder: (context, box, _) {
          //final transactions = box.values.toList().cast<TemrinModel>();
          List<TemrinModel> transactions = [];
          if (filtre != -1) {
            transactions = _box.values.where((object) => object.dersId == filtre).toList();
          } else {
            transactions = _box.values.toList().cast<TemrinModel>();
          }
          return buildContent(transactions);
        },
      );
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Center(child: Text('TNS-Temrin Listesi')),
      actions: <Widget>[
        PopupMenuButton<String>(
          onCanceled: () => _viewDersModel.setFiltreDersId(-1),
          onSelected: (value) {
            //print(value);
            _viewDersModel.setFiltreDersId(int.parse(value));
          },
          itemBuilder: (BuildContext context) {
            return DersBoxes.getTransactions().values.toList().cast<DersModel>().map((e) {
              return PopupMenuItem(
                value: e.id.toString(),
                child: Text(e.dersad),
              );
            }).toList();
          },
        ),
        IconButton(
          onPressed: () {
            exitAppDialog(context);
          },
          icon: IconsConstans.exitIcon,
        )
      ],
    );
  }

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

  Widget buildTransaction(BuildContext context, TemrinModel transaction, int index) {
    return TemrinCard(transaction: transaction, index: index, butons: buildButtons(context, transaction));
  }

  Future addTransaction(int id, String temrinKonusu, int dersId) async {
    final transaction = TemrinModel(id: id, temrinKonusu: temrinKonusu, dersId: dersId);

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
                    onClickedDone: (id, temrinKonusu, dersId) => editTransaction(transaction, id, temrinKonusu, dersId),
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
