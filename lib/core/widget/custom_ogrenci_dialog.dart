import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/ogrenci/store/ogrenci_store.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomOgrenciDialog extends StatefulWidget {
  final OgrenciModel? transaction;
  final int? gelenSinifId;

  final Function(int id, String name, int nu, int sinifId) onClickedDone;

  const CustomOgrenciDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
    required this.gelenSinifId,
  }) : super(key: key);

  @override
  _CustomOgrenciDialogState createState() => _CustomOgrenciDialogState();
}

class _CustomOgrenciDialogState extends BaseState<CustomOgrenciDialog> {
  final formKey = GlobalKey<FormState>();
  List<OgrenciModel> transactionsOgrenci = [];
  List<OgrenciModel> transactionsOgrenciGecici = [];
  OgrenciStore _viewModel = OgrenciStore();

  @override
  void initState() {
    super.initState();

    if (transactionsOgrenciGecici.isEmpty) {
      transactionsOgrenciGecici = OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
      for (var ogrenci in transactionsOgrenciGecici) {
        if (ogrenci.sinifId == widget.gelenSinifId) {
          transactionsOgrenci.add(ogrenci);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String ogrencisecText = "Öğrenci Seçiniz";
    return BaseView<OgrenciStore>(
      viewModel: _viewModel,
      onModelReady: (model) => _viewModel = model,
      onPageBuilder: (context, value) => AlertDialog(
        title: Text(ogrencisecText),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                buildOgrenci(context, transactionsOgrenci),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCancelButton(context),
              buildOkButton(context, buildOkButtononPressed),
            ],
          ),
        ],
      ),
    );
  }

  void buildOkButtononPressed() {
    //print(TemrinStore.TemrinAd);
    Navigator.of(context).pop(_viewModel);
  }

  Widget buildOgrenci(BuildContext context, List<OgrenciModel> transactionsOgrenci) => SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          onChanged: (value) {
            //print('seçilen $value');
            int ogrenciId = transactionsOgrenci.singleWhere((element) => element.name == value).id;
            _viewModel.setOgrenciId(ogrenciId);
            _viewModel.setFiltreOgrenciId(ogrenciId);
            _viewModel
                .setOgrenciAd(transactionsOgrenci.singleWhere((element) => element.id == _viewModel.ogrenciId).name);
            // print('storedan öğrenci id' + ogrenciId.toString());
          },
          selectedItem: _viewModel.ogrenciAd,
        ),
      );

  List<String> buildItems() {
    List<String> items = [];
    for (var item in transactionsOgrenci) {
      items.add(item.name);
    }
    return items;
  }
}
