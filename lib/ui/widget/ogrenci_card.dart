import 'package:flutter/material.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';

class OgrenciCard extends StatelessWidget {
  final OgrenciModel transaction;
  final int index;
  final Widget butons;

  const OgrenciCard(
      {Key? key,
      required this.transaction,
      required this.index,
      required this.butons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          (index + 1).toString() + " - " + transaction.name,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle:
            Text("id: ${transaction.id.toString()} Nu:  ${transaction.nu}"),
        children: [butons],
      ),
    );
  }
}
