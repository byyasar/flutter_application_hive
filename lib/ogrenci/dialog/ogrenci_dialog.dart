import 'package:flutter/material.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/view/boxes.dart';

class OgrenciDialog extends StatefulWidget {
  final OgrenciModel? transaction;

  final Function(int id, String name, int nu) onClickedDone;

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
  //final isCompletedController=

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      nameController.text = transaction.name;
      nuController.text = transaction.nu.toString();
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
    //final ogrenciModel = widget.transaction;
    final box = OgrenciBoxes.getTransactions();
    int sonId = isEditing ?  widget.transaction!.id:box.values.last.id + 1;

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildNu(),
              SizedBox(height: 8),
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

          widget.onClickedDone(id, name, nu);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
