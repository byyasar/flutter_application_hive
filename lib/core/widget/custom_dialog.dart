import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/dersler/store/ders_store.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomDersDialog extends StatefulWidget {
  final DersModel? transaction;

  final Function(int id, String dersAd) onClickedDone;

  const CustomDersDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _CustomDersDialogState createState() => _CustomDersDialogState();
}

class _CustomDersDialogState extends BaseState<CustomDersDialog> {
  final formKey = GlobalKey<FormState>();
  late DersStore viewModel;
  List<DersModel> transactionsDers = [];
  @override
  void initState() {
    super.initState();
    if (transactionsDers.isEmpty) {
      transactionsDers =
          DersBoxes.getTransactions().values.toList().cast<DersModel>();
    }
  }

  @override
  void dispose() {
    //dersadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String derssecText = "Ders Seçiniz";
    return BaseView<DersStore>(
      viewModel: DersStore(),
      onModelReady: (model) {
        viewModel = model;
      },
      onPageBuilder: (context, value) => AlertDialog(
        title: Text(derssecText),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                buildDers(context, transactionsDers),
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
    //print(DersStore.DersAd);
    Navigator.of(context).pop(viewModel);
  }

  Widget buildDers(BuildContext context, List<DersModel> transactionsDers) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          onChanged: (value) {
            //print('seçilen $value');
            int dersId = transactionsDers
                .singleWhere((element) => element.dersad == value)
                .id;
            viewModel.setDersId(dersId);
            viewModel.setFiltreDersId(dersId);
            viewModel.setDersAd(transactionsDers
                .singleWhere((element) => element.id == viewModel.dersId)
                .dersad);
            //print('storedan glen id' + DersStore.DersId.toString());
          },
          selectedItem: viewModel.dersAd,
        ),
      );

  List<String> buildItems() {
    List<String> items = DersBoxes.getTransactions()
        .values
        .map((e) => e.dersad.toString())
        .toList();
    return items;
  }
}
