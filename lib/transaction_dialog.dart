import 'package:flutter/material.dart';
import 'package:flutter_application_hive/model/task_model.dart';

class TransactionDialog extends StatefulWidget {
  final TaskModel? transaction;
  final Function(String title, String detail, bool isCompleted) onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  //final isCompletedController=

  bool isCompleted = false;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      titleController.text = transaction.title;
      detailController.text = transaction.detail;
      isCompleted = transaction.isCompleted;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildTitle(),
              SizedBox(height: 8),
              buildDetail(),
              SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildTitle() => TextFormField(
        controller: titleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter title',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDetail() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter detail',
        ),
        keyboardType: TextInputType.number,
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
        controller: detailController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('Tamamlandı'),
            value: true,
            groupValue: isCompleted,
            onChanged: (value) => setState(() => isCompleted = value!),
          ),
          RadioListTile<bool>(
            title: Text('Tamamlanmadı'),
            value: false,
            groupValue: isCompleted,
            onChanged: (value) => setState(() => isCompleted = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final title = titleController.text;
          final detail = detailController.text;

          widget.onClickedDone(title, detail, isCompleted);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
