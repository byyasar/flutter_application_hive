import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/add_button.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/siniflar/store/sinif_store.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DersDialog extends StatefulWidget {
  final DersModel? transaction;

  final Function(int id, String dersad, int sinifId) onClickedDone;

  const DersDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _DersDialogState createState() => _DersDialogState();
}

class _DersDialogState extends State<DersDialog> {
  final formKey = GlobalKey<FormState>();
  final dersadController = TextEditingController();
  SinifStore sinifStore = SinifStore();
  List<SinifModel> transactionsSinif = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      dersadController.text = transaction.dersad;
    }
    if (transactionsSinif.isEmpty) {
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
  }

  @override
  void dispose() {
    dersadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Dersi Düzenle' : 'Ders Ekle';
    final box = DersBoxes.getTransactions();
    int sonId;

    if (widget.transaction?.id == null) {
      isEditing
          ? sonId = widget.transaction!.id
          : (box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1);
    } else {
      sonId = isEditing ? widget.transaction!.id : 1;
      sinifStore.setSinifId(widget.transaction!.sinifId);
      sinifStore.setSinifAd(transactionsSinif
          .singleWhere((element) => element.id == widget.transaction!.sinifId)
          .sinifAd);
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
              builddersad(),
              const SizedBox(height: 8),
              buildSinif(context, transactionsSinif)
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
                    String? dersad = dersadController.text.toUpperCase();
                    widget.onClickedDone(sonId, dersad, sinifStore.sinifId);
                    Navigator.of(context).pop();
                  }
                }),
          ],
        ),
      ],
    );
  }

  Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          mode: Mode.MENU,
          items: buildItems(),
          //label: "Sınıflar",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int sinifid = transactionsSinif
                .singleWhere((element) => element.sinifAd == value)
                .id;
            sinifStore.setSinifId(sinifid);
            //print('storedan glen id' + sinifStore.sinifId.toString());
          },
          selectedItem: sinifStore.sinifAd,
        ),
      );

  Widget builddersad() => TextFormField(
        controller: dersadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ders Adını Giriniz',
        ),
        validator: (dersad) =>
            dersad != null && dersad.isEmpty ? 'Öğrenci Adını' : null,
      );

  /*  Widget buildAddButton(BuildContext context, int? sonId,
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
          String? dersad = dersadController.text.toUpperCase();
          // int? nu = int.parse(nuController.text);

          int id = sonId ?? 0;

          widget.onClickedDone(id, dersad, sinifStore.sinifId);

          Navigator.of(context).pop();
        }
      },
    );
  } */

  List<String> buildItems() {
    List<String> items = SinifBoxes.getTransactions()
        .values
        .map((e) => e.sinifAd.toString())
        .toList();
    return items;
  }
}
