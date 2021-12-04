import 'package:flutter/material.dart';

import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';

class DersDialog extends StatefulWidget {
  final DersModel? transaction;
  int sinifId = 0;

  final Function(int id, String dersad, int sinifId) onClickedDone;

  const DersDialog({
    Key? key,
    this.transaction,
    required this.sinifId,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _DersDialogState createState() => _DersDialogState();
}

class _DersDialogState extends State<DersDialog> {
  final formKey = GlobalKey<FormState>();
  final dersadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      dersadController.text = transaction.dersad;
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
    //final DersModel = widget.transaction;
    final box = DersBoxes.getTransactions();
    int sonId;
    //int sonId = isEditing ?  (widget.transaction.?id==null?0:widget.transaction.id):box.values.last.id + 1;
    if (widget.transaction?.id == null) {
      isEditing
          ? sonId = widget.transaction!.id
          : (box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1);
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
              builddersad(),
              const SizedBox(height: 8),
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

  Widget builddersad() => TextFormField(
        controller: dersadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ders Adını Giriniz',
        ),
        validator: (dersad) =>
            dersad != null && dersad.isEmpty ? 'Öğrenci Adını' : null,
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
          String? dersad = dersadController.text.toUpperCase();
          // int? nu = int.parse(nuController.text);

          int id = sonId ?? 0;
          int sinifId = widget.sinifId ?? 0;

          widget.onClickedDone(id, dersad, sinifId);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
