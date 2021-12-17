import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/add_button.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_application_hive/features/dersler/store/ders_store.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';

class TemrinDialog extends StatefulWidget {
  final TemrinModel? transaction;

  final Function(int id, String temrinKonusu, int dersId) onClickedDone;

  const TemrinDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TemrinDialogState createState() => _TemrinDialogState();
}

class _TemrinDialogState extends State<TemrinDialog> {
  final formKey = GlobalKey<FormState>();
  final temrinadController = TextEditingController();
  //SinifStore sinifStore = SinifStore();
  DersStore dersStore = DersStore();
  List<DersModel> transactionsDersler = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      temrinadController.text = transaction.temrinKonusu;
    }
    if (transactionsDersler.isEmpty) {
      transactionsDersler =
          DersBoxes.getTransactions().values.toList().cast<DersModel>();
    }
  }

  @override
  void dispose() {
    temrinadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Temrini Düzenle' : 'Temrin Ekle';
    final box = TemrinBoxes.getTransactions();
    int sonId;

    if (widget.transaction?.id == null) {
      isEditing
          ? sonId = widget.transaction!.id
          : (box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1);
    } else {
      sonId = isEditing ? widget.transaction!.id : 1;
      //sinifStore.setSinifId(widget.transaction!.sinifId);
      dersStore.setDersId(widget.transaction!.dersId);
      dersStore.setDersAd(transactionsDersler
          .singleWhere((element) => element.id == widget.transaction!.dersId)
          .dersad);
      //sinifStore.setSinifAd(transactionsSinif
      //    .singleWhere((element) => element.id == widget.transaction!.sinifId)
      //    .sinifAd);
    }

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildTemrinad(),
              const SizedBox(height: 8),
              buildDers(context, transactionsDersler)
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCancelButton(context),
            BuildAddButton(
              context: context,
              sonId: sonId,
              isEditing: isEditing,
              onPressed: () async {
                final isValid = formKey.currentState!.validate();

                if (isValid) {
                  String? temrinKonusu = temrinadController.text.toUpperCase();
                  // int? nu = int.parse(nuController.text);
                  //int id = sonId ?? 0;
                  widget.onClickedDone(sonId, temrinKonusu, dersStore.dersId);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDers(BuildContext context, List<DersModel> transactionsDersler) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          //label: "Dersler",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int dersId = transactionsDersler
                .singleWhere((element) => element.dersad == value)
                .id;
            dersStore.setDersId(dersId);
            //sinifStore.setSinifId(sinifid);
            //print('storedan gelen id' + dersStore.dersId.toString());
          },
          selectedItem: dersStore.dersAd,
        ),
      );

  Widget buildTemrinad() => TextFormField(
        controller: temrinadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Temrin Adını Giriniz',
        ),
        validator: (temrinAd) =>
            temrinAd != null && temrinAd.isEmpty ? 'Temrin Konusu' : null,
      );

/*   Widget buildAddButton(BuildContext context, int? sonId,
      {required bool isEditing}) {
    final text = isEditing ? 'Kaydet' : 'Ekle';

    return TextButton(
      child: Row(
        children: [
          Icon(Icons.add_box, color: Colors.green.shade400),
          Text(text),
        ],
      ),
              onPressed: () async {
                final isValid = formKey.currentState!.validate();

                if (isValid) {
                  String? temrinKonusu = temrinadController.text.toUpperCase();
                  // int? nu = int.parse(nuController.text);

                  int id = sonId ?? 0;

                  widget.onClickedDone(id, temrinKonusu, dersStore.dersId);

                  Navigator.of(context).pop();
                }
              },
    );
  } */

  List<String> buildItems() {
    List<String> items = DersBoxes.getTransactions()
        .values
        .map((e) => e.dersad.toString())
        .toList();
    return items;
  }
}
