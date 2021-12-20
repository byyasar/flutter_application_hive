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
            flex: 5,
            child: ListTile(
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
          Expanded(
              flex: 2,
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 3,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 28),
              )),
              //todo: bu alana kontrol eklenecek
          Spacer(
            flex: 1,
          )
          /*  Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ), */
        ],
      ),
    );
  }
}
//ANCHOR: ÖĞRENCİ KART
//TODO: ÖĞRENCİ KART