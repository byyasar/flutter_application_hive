import 'package:flutter/material.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/store/sinif_store.dart';

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
  String dropdownValue = "";
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      nameController.text = transaction.name;
      nuController.text = transaction.nu.toString();
    }
    if (transactionsSinif.isEmpty) {
      transactionsSinif =
          SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
      dropdownValue = transactionsSinif.first.sinifAd;
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
    /*  if (isEditing) {
      dropdownValue = transactionsSinif
          .singleWhere((element) => element.id == widget.transaction?.sinifId)
          .sinifAd;
    } else {
      dropdownValue = transactionsSinif.first.sinifAd;
      sinifId = transactionsSinif
          .singleWhere((element) => element.sinifAd == dropdownValue)
          .id;
    } */

    int sonId;
    if (widget.transaction?.id == null) {
      if (isEditing) {
        sonId = widget.transaction!.id;
        sinifStore.setSinifId(widget.transaction!.sinifId);
      } else {
        box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1;
      }
    } else {
      sonId = isEditing ? widget.transaction!.id : 1;
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
        buildCancelButton(context),
        buildAddButton(context, sonId, isEditing: isEditing),
      ],
    );
  }

  Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif) =>
      DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          dropdownValue = newValue!;
          sinifStore.setSinifId(transactionsSinif
              .singleWhere((element) => element.sinifAd == newValue)
              .id);
          sinifStore.setSinifAd(newValue);
         // setState(() {});
        },
        items:         
            transactionsSinif.map<DropdownMenuItem<String>>((SinifModel value) {
          return DropdownMenuItem<String>(
            value: value.sinifAd,
            child: Text(value.sinifAd),
          );
        }).toList(),
      );

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Öğrenci Adını Giriniz',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Öğrenci Adını' : null,
      );

  Widget buildNu() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Numarayı Giriniz',
        ),
        keyboardType: TextInputType.number,
        validator: (name) => name != null && name.isEmpty ? 'Nu' : null,
        controller: nuController,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('İptal'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, int? sonId,
      {required bool isEditing}) {
    final text = isEditing ? 'Kaydet' : 'Ekle';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          String? name = nameController.text.toUpperCase();
          int? nu = int.parse(nuController.text);

          int id = sonId ?? 0;
          int sinifId = sinifStore.sinifId;

          widget.onClickedDone(id, name, nu, sinifId);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
