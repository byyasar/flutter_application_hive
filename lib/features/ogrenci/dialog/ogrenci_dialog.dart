import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/widget/add_button.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/siniflar/store/sinif_store.dart';
import 'package:dropdown_search/dropdown_search.dart';

class OgrenciDialog extends StatefulWidget {
  final OgrenciModel? transaction;

  final Function(int id, String name, int nu, int sinifId) onClickedDone;

  const OgrenciDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _OgrenciDialogState createState() => _OgrenciDialogState();
}

class _OgrenciDialogState extends State<OgrenciDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nuController = TextEditingController();
  SinifStore sinifStore = SinifStore();

  //final isCompletedController=
  List<SinifModel> transactionsSinif = [];

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      nameController.text = transaction.name;
      nuController.text = transaction.nu.toString();
    }
    if (transactionsSinif.isEmpty) {
      /* transactionsSinif = SinifBoxes.getTransactions()
          .values
          .map((e) => e.sinifAd.toString())
          .toList(); */
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    nuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Öğrenciyi Düzenle' : 'Öğrenci Ekle';
    final box = OgrenciBoxes.getTransactions();
    int sonId;

    if (widget.transaction?.id == null) {
      if (isEditing) {
        sonId = widget.transaction!.id;
      } else {
        box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1;
      }
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
              buildName(),
              const SizedBox(height: 8),
              buildNu(),
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
                  String? name = nameController.text.toUpperCase();
                  int? nu = int.parse(nuController.text);
                  widget.onClickedDone(sonId, name, nu, sinifStore.sinifId);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        )
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
          //hint: "Sınıf seçiniz",
          onChanged: (value) {
            //print('seçilen $value');
            int sinifid = transactionsSinif
                .singleWhere((element) => element.sinifAd == value)
                .id;
            sinifStore.setSinifId(sinifid);
            //print('storedan glen id' + sinifStore.sinifId.toString());
          },
          selectedItem: sinifStore.sinifAd.isEmpty ? "" : sinifStore.sinifAd,
        ),
      );

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          label: Text("Öğrenci adı"),
          border: OutlineInputBorder(),
          hintText: 'Öğrenci Adını Giriniz',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Öğrenci Adını' : null,
      );

  Widget buildNu() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Öğrenci Nu"),
          hintText: 'Numarayı Giriniz',
        ),
        keyboardType: TextInputType.number,
        validator: (name) => name != null && name.isEmpty ? 'Nu' : null,
        controller: nuController,
      );

  /* Widget buildCancelButton(BuildContext context) => TextButton(
        child: Row(
          children: [
            Icon(
              Icons.cancel,
              color: Colors.red.shade400,
            ),
            const Text('İptal'),
          ],
        ),
        onPressed: () => Navigator.of(context).pop(),
      ); */
/* 
  Widget buildAddButton(BuildContext context, int? sonId,
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
          String? name = nameController.text.toUpperCase();
          int? nu = int.parse(nuController.text);

          int id = sonId ?? 0;
          //int sinifId = sId ?? 0;

          widget.onClickedDone(id, name, nu, sinifStore.sinifId);

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
