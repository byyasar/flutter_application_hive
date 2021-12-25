import 'package:flutter/material.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';

class CustomOgrenciCard extends StatefulWidget {
  final OgrenciModel transaction;
  final int index;
  final TextEditingController controller;

  const CustomOgrenciCard({
    Key? key,
    required this.transaction,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomOgrenciCard> createState() => _CustomOgrenciCardState();
}

class _CustomOgrenciCardState extends State<CustomOgrenciCard> {
  bool? _chacked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ExpansionTile(
              title: Text(
                (widget.index + 1).toString() + " - " + widget.transaction.name,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                  "ogrid: ${widget.transaction.id.toString()} Nu:  ${widget.transaction.nu} Sınıf ıd:  ${widget.transaction.sinifId}"),
              children: [
                TextFormField(),
                CheckboxListTile(
                    title: const Text("Gelmedi"),
                    value: _chacked,
                    onChanged: (value) {
                      setState(() {
                        _chacked = value;
                        
                      });
                    })
              ],
            ),
          ),
          Expanded(
              flex: 2,
              child: TextFormField(
                controller: widget.controller,
                textAlign: TextAlign.center,
                maxLength: 3,
                style: const TextStyle(color: Colors.blueAccent, fontSize: 28),
              )),
          //todo: bu alana kontrol eklenecek
          const Spacer(
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