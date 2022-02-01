import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/add_button.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';

class TemrinnotDialog extends StatefulWidget {
  final TemrinnotModel? transaction;

  final Function(int id, int temrinId, int ogrenciId, int puan, String notlar) onClickedDone;

  const TemrinnotDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TemrinnotDialogState createState() => _TemrinnotDialogState();
}

class _TemrinnotDialogState extends State<TemrinnotDialog> {
  final formKey = GlobalKey<FormState>();
  final temrinnotnotlarController = TextEditingController();
  final temrinnotpuanController = TextEditingController();

  List<TemrinModel> transactionsTemrin = [];
  List<OgrenciModel> transactionsOgrenci = [];
  List<SinifModel> transactionsSinif = [];
  List<DersModel> transactionsDers = [];

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      temrinnotnotlarController.text = transaction.notlar;
      temrinnotpuanController.text = transaction.puan.toString();
    }
    if (transactionsSinif.isEmpty) {
      transactionsSinif = SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    }
    if (transactionsTemrin.isEmpty) {
      transactionsTemrin = TemrinBoxes.getTransactions().values.toList().cast<TemrinModel>();
    }
    if (transactionsOgrenci.isEmpty) {
      transactionsOgrenci = OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
    }
    if (transactionsDers.isEmpty) {
      transactionsDers = DersBoxes.getTransactions().values.toList().cast<DersModel>();
    }
  }

  @override
  void dispose() {
    temrinnotnotlarController.dispose();
    temrinnotpuanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Temrinnot Düzenle' : 'Temrinnot Ekle';
    final box = TemrinnotBoxes.getTransactions();
    int sonId;

    if (widget.transaction?.temrinId == null) {
      isEditing ? sonId = widget.transaction!.id : (box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1);
    } else {
      sonId = isEditing ? widget.transaction!.id : 1;
      //sinifStore.setSinifId(widget.transaction!.sinifId);
      //dersStore.setDersId(widget.transaction!.dersId);
      //dersStore.setDersAd(transactionsDersler    .singleWhere((element) => element.id == widget.transaction!.dersId)          .dersad);
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
              buildTemrinnotad(),
              const SizedBox(height: 8),
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
            BuildAddButton(
              context: context,
              sonId: sonId,
              isEditing: isEditing,
              onPressed: () async {
                final isValid = formKey.currentState!.validate();

                if (isValid) {
                  int temrinId = 0;
                  int ogrenciId = 0;
                  int temrinnotPuan = int.tryParse(temrinnotpuanController.text)!;
                  String temrinnotNotlar = temrinnotnotlarController.text;
                  widget.onClickedDone(sonId, temrinId, ogrenciId, temrinnotPuan, temrinnotNotlar);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTemrinnotad() => TextFormField(
        controller: temrinnotnotlarController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Temrinnot Adını Giriniz',
        ),
        validator: (temrinnotnotlar) => temrinnotnotlar != null && temrinnotnotlar.isEmpty ? 'Temrinnot Konusu' : null,
      );

  List<String> buildItems() {
    List<String> items = DersBoxes.getTransactions().values.map((e) => e.dersad.toString()).toList();
    return items;
  }
}
