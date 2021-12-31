import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';

class DersCard extends StatelessWidget {
  final DersModel transaction;
  final int index;
  final Widget butons;

  const DersCard({Key? key, required this.transaction, required this.index, required this.butons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);
    //final Box<SinifModel> _boxSinif = SinifBoxes.getTransactions();
    //final Box<DersModel> _boxDers = DersBoxes.getTransactions();
    return Card(
      color: Colors.white60,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          (index + 1).toString() + " - " + transaction.dersad,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
            "id: ${transaction.id.toString()} sinif : ${_sinifListesiHelper.getItemId(transaction.sinifId)!.sinifAd}"),
        children: [butons],
      ),
    );
  }
}
