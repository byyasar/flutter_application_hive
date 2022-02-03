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
  final TextEditingController kriter1Controller;
  final TextEditingController kriter2Controller;
  final TextEditingController kriter3Controller;
  final TextEditingController kriter4Controller;
  final TextEditingController kriter5Controller;

  const CustomOgrenciCard({
    Key? key,
    required this.transaction,
    required this.index,
    required this.puanController,
    required this.aciklamaController,
    required this.kriter1Controller,
    required this.kriter2Controller,
    required this.kriter3Controller,
    required this.kriter4Controller,
    required this.kriter5Controller,
  }) : super(key: key);

  @override
  State<CustomOgrenciCard> createState() => _CustomOgrenciCardState();
}

class _CustomOgrenciCardState extends State<CustomOgrenciCard> {
  @override
  Widget build(BuildContext context) {
    SinifListesiHelper _sinifListesiHelper = SinifListesiHelper(ApplicationConstants.boxSinif);
    return Card(
      //color: Colors.white60,
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: ListTile(
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
                  /*children: [
                TextFormField(
                    decoration: const InputDecoration(labelText: '1-Bilgi -20P', focusColor: Colors.blue),
                    controller: widget.kriter1Controller),
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: '2-Çözümü anlama ve aktarma -30P', focusColor: Colors.blue),
                    controller: widget.kriter2Controller),
                TextFormField(
                    decoration: const InputDecoration(
                        labelText: '3-Doğru şekilde uygulama ve çalıştırma -30P', focusColor: Colors.blue),
                    controller: widget.kriter3Controller),
                TextFormField(
                    decoration: const InputDecoration(labelText: '4-Tasarım -10P', focusColor: Colors.blue),
                    controller: widget.kriter4Controller),
                TextFormField(
                    decoration: const InputDecoration(labelText: '5-Süre -10P', focusColor: Colors.blue),
                    controller: widget.kriter5Controller),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Açıklama', focusColor: Colors.blue),
                    controller: widget.aciklamaController),
              ], */
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(child: Text( widget.puanController!.text),)
                      
                      /* TextFormField(
                        onTap: () => widget.puanController!.clear(),
                        controller: widget.puanController,
                        textAlign: TextAlign.center,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 28),
                      )*/), 
                ],
              ),
              onLongPress:(){debugPrint('uzun basıldı ${widget.puanController}');},
              subtitle: Text(
                  "Nu: ${widget.transaction.nu} Sınıf: ${_sinifListesiHelper.getItemId(widget.transaction.sinifId)!.sinifAd}"),
              
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  widget.puanController!.text = "G";
                },
                icon: IconsConstans.gelmediIcon),
          ),
        ],
      ),
    );
  }
}
