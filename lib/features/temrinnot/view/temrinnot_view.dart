import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_card.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:hive/hive.dart';
//import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TemrinNotViewPage extends StatefulWidget {
  List parametreler = [];

  TemrinNotViewPage({Key? key, required this.parametreler}) : super(key: key);

  @override
  _TemrinNotViewPageState createState() => _TemrinNotViewPageState();
}

class _TemrinNotViewPageState extends BaseState<TemrinNotViewPage> {
  List<TextEditingController> _puanControllers = [];
  List<TextEditingController> _aciklamaControllers = [];
  List<OgrenciModel> _transactionsOgrenciSinif = [];
  List<TemrinnotModel> _transactionsTemrinnot = [];
  List<int> _puanlar = [];

  @override
  initState() {
    super.initState();
    _buildSinifListesi();
    _gettemrinnotdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFlaotingActionButton(),
        appBar: AppBar(title: const Text('TNS-Temrin Not Girişi'), centerTitle: true),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                  ' Sınıf:${widget.parametreler[0]} Ders :${widget.parametreler[1]} Temrin: ${widget.parametreler[2]}'),
              SizedBox(
                height: dynamicHeight(.8),
                child: FutureBuilder(
                    future: TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
                        .temrinnotFiltreListesiGetir(widget.parametreler[2]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return _buildOgrenciListesi(context, widget.parametreler[0], snapshot.data);
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

  Widget _buildFlaotingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: '1',
          child: const Icon(Icons.list),
          onPressed: () {
            //_buildTemrinNotKaydet();
            _buildTemrinNotListele();
          },
        ),
        FloatingActionButton(
          heroTag: '2',
          child: const Icon(Icons.save),
          onPressed: () {
            _buildTemrinNotKaydet();
          },
        ),
        FloatingActionButton(
          heroTag: '3',
          child: const Icon(Icons.clear),
          onPressed: () {
            _buildTemrinNotSil();
          },
        ),
      ],
    );
  }

  _buildOgrenciListesi(BuildContext context, int filtreSinifId, List<TemrinnotModel> temrinnotModelList) {
    // List filtretemrinList = [];
    //filtretemrinList = temrinnotModelList;

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: _transactionsOgrenciSinif.length,
      itemBuilder: (BuildContext context, int index) {
        _puanlar[index] = int.parse(_puanControllers[index].text.isEmpty ? '0' : _puanControllers[index].text);
        _aciklamaControllers[index].text = _aciklamaBosKontrol(index);
        final transaction = _transactionsOgrenciSinif[index];
        return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          puanController: _puanControllers[index],
          aciklamaController: _aciklamaControllers[index],
        );
      },
    );
  }

  String _aciklamaBosKontrol(int index) {
    return _aciklamaControllers[index].text.isEmpty ? '' : _aciklamaControllers[index].text;
  }

  void _buildTemrinNotKaydet() {
    String key = "";
    for (var i = 0; i < _transactionsOgrenciSinif.length; i++) {
      key =
          "${widget.parametreler[0]}-${widget.parametreler[1]}-${widget.parametreler[2]}-${_transactionsOgrenciSinif[i].id}";
      _addTransactionTemrinnot(key, i, widget.parametreler[2], _transactionsOgrenciSinif[i].id,
          int.parse(_puanControllers[i].text.isEmpty ? '0' : _puanControllers[i].text), _aciklamaBosKontrol(i));
    }
  }

  Future _addTransactionTemrinnot(String key, int id, int temrinId, int ogrenciId, int puan, String notlar) async {
    final transaction =
        TemrinnotModel(id: id, temrinId: temrinId, ogrenciId: ogrenciId, puan: puan, notlar: notlar, gelmedi: false);
    final box = TemrinnotBoxes.getTransactions();
    box.put(key, transaction);
  }

  void _buildTemrinNotListele() async {
    _transactionsTemrinnot = await TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
        .temrinnotFiltreListesiGetir(widget.parametreler[2]);
    /* for (var item in _transactionsTemrinnot) {
    //  print('id: ${item.id} öğrenci id: ${item.ogrenciId} puan: ${item.puan} ${item.key}');
      // _puanlar[item.id] = item.puan;
    } */
  }

  Future<void> _buildTemrinNotSil() async {
    final Box<TemrinnotModel> _box = TemrinnotBoxes.getTransactions();
    await _box.clear();
  }

  _gettemrinnotdata() async {
    _transactionsTemrinnot = await TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
        .temrinnotFiltreListesiGetir(widget.parametreler[2]);
    for (var item in _transactionsTemrinnot) {
      // print('Tid: ${item.temrinId} id: ${item.id} öğrenci id: ${item.ogrenciId} puan: ${item.puan} ${item.key}');
      _puanControllers[item.id].text = item.puan.toString();
      _aciklamaControllers[item.id].text = item.notlar;
    }
  }

  void _buildSinifListesi() {
    _puanControllers = [];
    _aciklamaControllers = [];
    _puanlar = [];
    _transactionsOgrenciSinif =
        OgrenciListesiHelper(ApplicationConstants.boxOgrenci).getFilteredValues('SinifId', widget.parametreler[0])!;
    for (var i = 0; i < _transactionsOgrenciSinif.length; i++) {
      _puanControllers.add(TextEditingController());
      _aciklamaControllers.add(TextEditingController());
      _puanlar.add(0);
    }
  }
}
