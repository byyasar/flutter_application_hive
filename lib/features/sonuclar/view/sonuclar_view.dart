import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
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
  //List<int> _puanlar = [];
  final Box<TemrinModel> _box = TemrinBoxes.getTransactions();
  int toplam = 0;

  @override
  initState() {
    super.initState();
    _buildtemrinListesi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButton: _buildFlaotingActionButton(),
        appBar: AppBar(title: const Text('Sonuclar Listesi'), centerTitle: true),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                  ' Sınıf:${widget.parametreler[0]} Ders :${widget.parametreler[1]} Ogrenci Id: ${widget.parametreler[2]} Toplam=$toplam'),
              SizedBox(
                height: dynamicHeight(.8),
                child: FutureBuilder(
                    future: TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot).fetcAlldata(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return _buildOgrenciNotListesi(context, snapshot.data);
                      } else {
                        return const Text("Datayok");
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

/*
dersin temrin sayısı alınacak

*/
  Widget _buildOgrenciNotListesi(BuildContext context, List<TemrinnotModel> data) {
    if (_transactionTemrin.isNotEmpty) {
      List<TemrinnotModel> dataGecici = [];
      for (var i = 0; i < _transactionTemrin.length; i++) {
        String key =
            '${widget.parametreler[0]}-${widget.parametreler[1]}-${_transactionTemrin[i].id}-${widget.parametreler[2]}';
        for (var item in data) {
          if (item.key == key) {
            toplam += item.puan;
            dataGecici.add(item);
          }
        }
      }

      //print(_transactionTemrin.length);

      return ListView.builder(
          itemCount: dataGecici.length,
          itemBuilder: (BuildContext context, int index) {
            return Text('id:${dataGecici[index].id} key:${dataGecici[index].key} puan:${dataGecici[index].puan}');
          });
    } else {
      return const Text('data');
    }
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
