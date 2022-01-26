import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/features/helper/sinif_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';

class CustomOgrenciCard extends StatefulWidget {
  final OgrenciModel transaction;
  final int index;
  final TextEditingController? puanController;
  final TextEditingController aciklamaController;

  const CustomOgrenciCard({
    Key? key,
    required this.transaction,
    required this.index,
    required this.puanController,
    required this.aciklamaController,
  }) : super(key: key);

  @override
  State<CustomOgrenciCard> createState() => _CustomOgrenciCardState();
}

class _CustomOgrenciCardState extends State<CustomOgrenciCard> {
  @override
  Widget build(BuildContext context) {
    SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);
    return Card(
      color: Colors.white60,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      (widget.index + 1).toString() + " - " + widget.transaction.name,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  //const Spacer(flex: 1),
                  Expanded(
                      flex: 3,
                      child: TextFormField(
                        onTap: () => widget.puanController!.clear(),
                        controller: widget.puanController,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.blueAccent, fontSize: 28),
                      )),
                ],
              ),
              subtitle: Text(
                  "Nu: ${widget.transaction.nu} Sınıf: ${_sinifListesiHelper.getItemId(widget.transaction.sinifId)!.sinifAd}"),
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Açıklama',
                    focusColor: Colors.blue,
                  ),
                  controller: widget.aciklamaController,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  widget.puanController!.text = "G";
                },
                icon: IconsConstans.exitIcon),
          ),

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