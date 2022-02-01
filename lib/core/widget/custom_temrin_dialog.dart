import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrin/store/temrin_store.dart';

class CustomTemrinDialog extends StatefulWidget {
  final TemrinModel? transaction;
  final int? gelenDersId;

  final Function(int id, String temrinKonusu, int dersId) onClickedDone;

  const CustomTemrinDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
    required this.gelenDersId,
  }) : super(key: key);

  @override
  _CustomTemrinDialogState createState() => _CustomTemrinDialogState();
}

class _CustomTemrinDialogState extends BaseState<CustomTemrinDialog> {
  final formKey = GlobalKey<FormState>();
  late TemrinStore viewModel;
  List<TemrinModel> transactionsTemrin = [];
  List<TemrinModel> transactionsTemrinGecici = [];
  @override
  void initState() {
    super.initState();

    if (transactionsTemrinGecici.isEmpty) {
      transactionsTemrinGecici =
          TemrinBoxes.getTransactions().values.toList().cast<TemrinModel>();
      for (var temrin in transactionsTemrinGecici) {
        if (temrin.dersId == widget.gelenDersId) {
          transactionsTemrin.add(temrin);
        }
      }
    }
  }

  @override
  void dispose() {
    //TemrinadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String temrinsecText = "Temrin Seçiniz";
    return BaseView<TemrinStore>(
      viewModel: TemrinStore(),
      onModelReady: (model) {
        viewModel = model;
      },
      onPageBuilder: (context, value) => AlertDialog(
        title: Text(temrinsecText),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                buildTemrin(context, transactionsTemrin),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCancelButton(context),
               const SizedBox(width: 10),
              buildOkButton(context, buildOkButtononPressed),
            ],
          ),
        ],
      ),
    );
  }

  void buildOkButtononPressed() {
    //print(TemrinStore.TemrinAd);
    Navigator.of(context).pop(viewModel);
  }

  Widget buildTemrin(BuildContext context, List<TemrinModel> transactionsTemrin) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          onChanged: (value) {
            //print('seçilen $value');
            int temrinId = transactionsTemrin
                .singleWhere((element) => element.temrinKonusu == value)
                .id;
            viewModel.settemrinId(temrinId);
            viewModel.setFiltretemrinId(temrinId);
            viewModel.settemrinKonusu(transactionsTemrin
                .singleWhere((element) => element.id == viewModel.temrinId)
                .temrinKonusu);
            //print('storedan glen id' + TemrinStore.TemrinId.toString());
          },
          selectedItem: viewModel.temrinKonusu,
        ),
      );

  List<String> buildItems() {
    List<String> items = [];
    for (var item in transactionsTemrin) {
      items.add(item.temrinKonusu);
    }
    return items;
  }
}
