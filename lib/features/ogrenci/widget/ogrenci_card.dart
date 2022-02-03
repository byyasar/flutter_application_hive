import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';

class OgrenciCard extends StatelessWidget {
  final OgrenciModel transaction;
  final int index;
  final Widget butons;

  const OgrenciCard({Key? key, required this.transaction, required this.index, required this.butons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);

    return Card(
      //color: Colors.white60,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          (index + 1).toString() + " - " + transaction.name,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
            "id: ${transaction.id.toString()} Nu:  ${transaction.nu} sinif : ${_sinifListesiHelper.getItemId(transaction.sinifId)!.sinifAd}"),
        children: [butons],
      ),
    );
  }
}
