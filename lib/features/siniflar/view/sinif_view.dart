import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/custom_appbar.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
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
  final Box<SinifModel> _box = SinifBoxes.getTransactions();
  final SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: customAppBar(context, 'TNS-Sınıf Listesi'),
        body: _buildBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingAcionButton(context),
      );

  ValueListenableBuilder<Box<SinifModel>> get _buildBody {
    return ValueListenableBuilder<Box<SinifModel>>(
      valueListenable: _box.listenable(),
      builder: (context, _box, _) {
        final transactions = _box.values.toList().cast<SinifModel>();
        return buildContent(transactions);
      },
    );
  }

  Padding _buildFloatingAcionButton(BuildContext context) {
    return Padding(
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
    );
  }

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

  Widget buildTransaction(BuildContext context, SinifModel sinifModel, int index) {
    return SinifCard(transaction: sinifModel, index: index, butons: buildButtons(context, sinifModel));
  }

  Future addTransaction(int id, String sinifAd) async {
    final sinifModel = SinifModel(id: id, sinifAd: sinifAd);
    _sinifListesiHelper.addItem(sinifModel);
  }

  Widget buildButtons(BuildContext context, SinifModel sinifModel) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SinifDialog(
                    transaction: sinifModel,
                    onClickedDone: (id, sinifAd) => editTransaction(sinifModel, id, sinifAd),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Sil'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(sinifModel),
            ),
          )
        ],
      );

  deleteTransaction(SinifModel sinifModel) => _sinifListesiHelper.deleteItem(sinifModel);

  editTransaction(SinifModel sinifModel, int id, String sinifAd) {
    sinifModel.id = id;
    sinifModel.sinifAd = sinifAd;
    _sinifListesiHelper.editItem(sinifModel);
  }
}
