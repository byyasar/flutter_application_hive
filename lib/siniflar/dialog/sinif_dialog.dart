import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';

class SinifDialog extends StatefulWidget {
  final SinifModel? transaction;

  final Function(int id, String sinifAd) onClickedDone;

  const SinifDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _SinifDialogState createState() => _SinifDialogState();
}

class _SinifDialogState extends State<SinifDialog> {
  final formKey = GlobalKey<FormState>();
  final sinifadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      sinifadController.text = transaction.sinifAd;
    }
  }

  @override
  void dispose() {
    sinifadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Sinifi Düzenle' : 'Sinif Ekle';
    //final SinifModel = widget.transaction;
    final box = SinifBoxes.getTransactions();
    int sonId;
    //int sonId = isEditing ?  (widget.transaction.?id==null?0:widget.transaction.id):box.values.last.id + 1;
    if (widget.transaction?.id == null) {
      isEditing
          ? sonId = widget.transaction!.id
          : (box.values.isEmpty
              ? sonId = 1
              : sonId = box.values.last.id + 1);
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
              buildSinifad(),
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

  Widget buildSinifad() => TextFormField(
        controller: sinifadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Sinif Adını Giriniz',
        ),
        validator: (sinifAd) =>
            sinifAd != null && sinifAd.isEmpty ? 'Sınıf Adını Yazınız' : null,
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
          String? sinifAd = sinifadController.text.toUpperCase();
          // int? nu = int.parse(nuController.text);

          int id = sonId ?? 0;

          widget.onClickedDone(id, sinifAd);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
