import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/sonuclar/store/sonuc_store.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
//import 'package:logger/logger.dart';

class SonuclarViewPage extends StatefulWidget {
  List parametreler = [];

  SonuclarViewPage({Key? key, required this.parametreler}) : super(key: key);

  @override
  _SonuclarViewPageState createState() => _SonuclarViewPageState();
}

class _SonuclarViewPageState extends BaseState<SonuclarViewPage> {
  List<TemrinModel> _transactionTemrin = [];
  final _viewModelSonuc = SonucStore();
  final Box<TemrinModel> _box = TemrinBoxes.getTransactions();
  List<TemrinnotModel>? _transactionTemrinnot = [];
  List<TemrinnotModel>? _transactionTemrinnotGecici = [];

  @override
  initState() {
    super.initState();

    _buildtemrinListesi();
    _viewModelSonuc.setSayacSifirla();
    _buildOrtalamaHesapla();
  }

  _buildOrtalamaHesapla() {
    _transactionTemrinnot = [];
    _transactionTemrinnotGecici = [];
    _transactionTemrinnot = TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot).getValues();
    for (var i = 0; i < _transactionTemrin.length; i++) {
      String key =
          '${widget.parametreler[0]}-${widget.parametreler[1]}-${_transactionTemrin[i].id}-${widget.parametreler[2]}';
      if (_transactionTemrinnot!.isNotEmpty) {
        for (var item in _transactionTemrinnot!) {
          if (item.key == key) {
            if (item.puan != -1) {
              _viewModelSonuc.sayacArttir();
              _viewModelSonuc.toplamaEkle(item.puan);
            }

            _transactionTemrinnotGecici!.add(item);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButton: _buildFlaotingActionButton(),
        appBar: AppBar(title: const Text('Öğrenci Notları'), centerTitle: true),
        body: Container(
          height: dynamicHeight(1),
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: dynamicHeight(.01)),
              _buildOrtalama(),
              SizedBox(height: dynamicHeight(.01)),
              //Text(
              //    'Öğrenci ${widget.parametreler[3]} Sınıf:${widget.parametreler[0]} Ders :${widget.parametreler[1]} Ogrenci Id: ${widget.parametreler[2]} '),
              Expanded(child: _buildOgrenciNotListesi(context, _transactionTemrinnotGecici!)),
              SizedBox(height: dynamicHeight(.01)),
            ],
          ),
        ),
      ),
    );
  }

  Observer _buildOrtalama() {
    return Observer(
      builder: (context) => Card(
        color: Colors.yellowAccent.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: ListTile(
            trailing: Column(
              children: [
                const Text('Ortalama'),
                CircleAvatar(
                    radius: 18,
                    child: Text('${_viewModelSonuc.ortalama.isNaN ? "-" : _viewModelSonuc.ortalama.round()}')),
              ],
            ),
            subtitle:
                Text('${widget.parametreler[4]}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            title:
                Text('${widget.parametreler[3]}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ),
    );
  }

/*
dersin temrin sayısı alınacak

*/
  Widget _buildOgrenciNotListesi(BuildContext context, List<TemrinnotModel> data) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: dynamicHeight(.1),
            // color: Colors.amber,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(radius: 12, child: Text('${index + 1}')),
                trailing: CircleAvatar(
                  backgroundColor: data[index].puan <= 0 ? Colors.red.shade300 : Colors.yellow.shade100,
                  child: Text('${data[index].puan == -1 ? 'G' : data[index].puan}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                title: Text(
                    '${_transactionTemrin.singleWhere((element) => element.id == data[index].temrinId).temrinKonusu} '),
                //subtitle: Text('key: ${data[index].key} Tid ${data[index].temrinId} puan ${data[index].puan}'),
                subtitle: Text('Notlar: ${data[index].notlar}'),
              ),
            ),
          );
        });
  }

  List<TemrinModel>? _buildtemrinListesi() {
    int filtre = widget.parametreler[1];
    _transactionTemrin = [];
    if (filtre != -1) {
      _transactionTemrin = _box.values.where((object) => object.dersId == filtre).toList();
    }
    return _transactionTemrin;
  }
}
