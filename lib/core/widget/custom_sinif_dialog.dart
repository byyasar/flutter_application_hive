import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/siniflar/store/sinif_store.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CustomSinifDialog extends StatefulWidget {
  final SinifModel? transaction;

  final Function(int id, String sinifAd) onClickedDone;

  const CustomSinifDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _CustomSinifDialogState createState() => _CustomSinifDialogState();
}

class _CustomSinifDialogState extends BaseState<CustomSinifDialog> {
  final formKey = GlobalKey<FormState>();
  //final dersadController = TextEditingController();
  //SinifStore sinifStore = SinifStore();
  late SinifStore viewModel;
  List<SinifModel> transactionsSinif = [];
  @override
  void initState() {
    super.initState();
    if (transactionsSinif.isEmpty) {
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
  }

  @override
  void dispose() {
    //dersadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String sinifsecText = "Sınıf Seçiniz";
    return BaseView<SinifStore>(
      viewModel: SinifStore(),
      onModelReady: (model) {
        viewModel = model;
      },
      onPageBuilder: (context, value) => AlertDialog(
        title: Text(sinifsecText),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 8),
                buildSinif(context, transactionsSinif),
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
    //print(sinifStore.sinifAd);
    Navigator.of(context).pop(viewModel);
  }

  Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          onChanged: (value) {
            if (value == null) viewModel.setFiltreSinifId(-1);
            //print('seçilen $value');
            int sinifid = transactionsSinif
                .singleWhere((element) => element.sinifAd == value)
                .id;
            viewModel.setSinifId(sinifid);
            viewModel.setFiltreSinifId(sinifid);
            viewModel.setSinifAd(transactionsSinif
                .singleWhere((element) => element.id == viewModel.sinifId)
                .sinifAd);
            //print('storedan glen id' + sinifStore.sinifId.toString());
          },
          selectedItem: viewModel.sinifAd,
        ),
      );

  List<String> buildItems() {
    List<String> items = SinifBoxes.getTransactions()
        .values
        .map((e) => e.sinifAd.toString())
        .toList();
    return items;
  }
}
