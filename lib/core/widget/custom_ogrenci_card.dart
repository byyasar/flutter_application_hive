import 'package:flutter/material.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';

class CustomOgrenciCard extends StatelessWidget {
  final OgrenciModel transaction;
  final int index;

  const CustomOgrenciCard({
    Key? key,
    required this.transaction,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              title: Text(
                (index + 1).toString() + " - " + transaction.name,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                  "id: ${transaction.id.toString()} Nu:  ${transaction.nu} Sınıf ıd:  ${transaction.sinifId}"),
            ),
          ),
          Expanded(flex: 1, child: TextFormField()),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                child: const Icon(Icons.save),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}
//ANCHOR: ÖĞRENCİ KART
//TODO: ÖĞRENCİ KART