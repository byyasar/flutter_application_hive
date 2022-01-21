import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/dialog/ogrenci_dialog.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/widget/ogrenci_card.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OgrencipageView extends StatefulWidget {
  const OgrencipageView({Key? key}) : super(key: key);

  @override
  _OgrencipageViewState createState() => _OgrencipageViewState();
}

class _OgrencipageViewState extends State<OgrencipageView> {
  SinifStore sinifStore = SinifStore();
  final Box<OgrenciModel> _box = OgrenciBoxes.getTransactions();
  final OgrenciListesiHelper _ogrenciListesiHelper = OgrenciListesiHelper(ApplicationConstants.boxOgrenci);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar,
        body: _buildBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context),
      );

  Observer get _buildBody {
    return Observer(builder: (_) {
      int filtre = sinifStore.filtreSinifId;
      return ValueListenableBuilder<Box<OgrenciModel>>(
        valueListenable: _box.listenable(),
        builder: (context, _box, _) {
          List<OgrenciModel> transactions = [];
          if (filtre != -1) {
            transactions = _box.values.where((object) => object.sinifId == filtre).toList();
          } else {
            transactions = _box.values.toList().cast<OgrenciModel>();
          }
          return buildContent(transactions);
        },
      );
    });
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => OgrenciDialog(
            onClickedDone: addTransaction,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget get _buildAppBar {
    return AppBar(
      title: const Text('Öğrenci Listesi'),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton<String>(
          onCanceled: () => sinifStore.setFiltreSinifId(-1),
          onSelected: (value) {
            //print(value);
            sinifStore.setFiltreSinifId(int.parse(value));
          },
          itemBuilder: (BuildContext context) {
            return SinifBoxes.getTransactions().values.toList().cast<SinifModel>().map((e) {
              return PopupMenuItem(
                value: e.id.toString(),
                child: Text(e.sinifAd),
              );
            }).toList();
          },
        )
      ],
    );
  }

  Widget buildContent(List<OgrenciModel> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Text(
          'Henüz öğrenci yok!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                final ogrenciModel = transactions[index];
                return buildTransaction(context, ogrenciModel, index);
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    }
  }

  Widget buildTransaction(BuildContext context, OgrenciModel ogrenciModel, int index) {
    return OgrenciCard(transaction: ogrenciModel, index: index, butons: buildButtons(context, ogrenciModel));
  }

  Future addTransaction(int id, String name, int nu, int sinifId) async {
    OgrenciModel yeniOgrenci = OgrenciModel(id: id, name: name, nu: nu, sinifId: sinifId);
    _ogrenciListesiHelper.addItem(yeniOgrenci);
  }

  void editTransaction(OgrenciModel ogrenciModel, int id, String name, int nu, int sinifId) {
    ogrenciModel.id = id;
    ogrenciModel.name = name;
    ogrenciModel.nu = nu;
    ogrenciModel.sinifId = sinifId;
    _ogrenciListesiHelper.editItem(ogrenciModel);
  }

  void buildDeleteOgrenci(OgrenciModel ogrenciModel) {
    _ogrenciListesiHelper.deleteItem(ogrenciModel);
  }

  Widget buildButtons(BuildContext context, OgrenciModel ogrenciModel) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OgrenciDialog(
                    transaction: ogrenciModel,
                    onClickedDone: (id, name, nu, sinifId) => editTransaction(ogrenciModel, id, name, nu, sinifId),
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
                onPressed: () {
                  buildDeleteOgrenci(ogrenciModel);
                }),
          )
        ],
      );
}
