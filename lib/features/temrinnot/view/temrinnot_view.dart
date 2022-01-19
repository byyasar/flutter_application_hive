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
import 'package:logger/logger.dart';

class TemrinNotViewPage extends StatefulWidget {
  List parametreler = [];

  TemrinNotViewPage({Key? key, required this.parametreler}) : super(key: key);

  @override
  _TemrinNotViewPageState createState() => _TemrinNotViewPageState();
}

class _TemrinNotViewPageState extends BaseState<TemrinNotViewPage> {
  List<TextEditingController> _controllers = [];
  //final TextEditingController _controller = TextEditingController();
  List<OgrenciModel> _transactionsOgrenciSinif = [];
  List<TemrinnotModel> _transactionsTemrinnot = [];
  List<int> _puanlar = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFlaotingActionButton(),
        appBar:
            AppBar(title: const Text('Temrinnot Listesi'), centerTitle: true),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                  'Ders :${widget.parametreler[0]} Sınıf: ${widget.parametreler[1]} Temrin: ${widget.parametreler[2]}'),
              Container(
                height: dynamicHeight(.8),
                child: FutureBuilder(
                    future: TemrinnotListesiHelper(
                            ApplicationConstants.boxTemrinNot)
                        .temrinnotFiltreListesiGetir(widget.parametreler[2]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return _buildOgrenciListesi(
                            context, widget.parametreler[0], snapshot.data);
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
      mainAxisAlignment: MainAxisAlignment.center,
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

  _buildOgrenciListesi(BuildContext context, int filtreSinifId,
      List<TemrinnotModel> temrinnotModelList) {
    // List filtretemrinList = [];
    //filtretemrinList = temrinnotModelList;
    _controllers = [];

    _transactionsOgrenciSinif =
        OgrenciListesiHelper(ApplicationConstants.boxOgrenci)
            .getFilteredValues('SinifId', widget.parametreler[0])!;
    for (var i = 0; i < _transactionsOgrenciSinif.length; i++) {
      _controllers.add(TextEditingController());
      _puanlar.add(0);
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: _transactionsOgrenciSinif.length,
      itemBuilder: (BuildContext context, int index) {
        _puanlar[index] = int.parse(
            _controllers[index].text.isEmpty ? '0' : _controllers[index].text);
        // _controllers.add(TextEditingController());
        _controllers[index] = TextEditingController();
        _controllers[index].text = _puanlar[index].toString();
        final transaction = _transactionsOgrenciSinif[index];
        return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          controller: _controllers[index],
        );
      },
    );
  }

  void _buildTemrinNotKaydet() {
    /* Logger().i(_controllers.length);*/
    /*  for (var puan in _controllers) {
      print(puan.text);
    } */
    String key = "";
    for (var i = 0; i < _transactionsOgrenciSinif.length; i++) {
      key =
          "${widget.parametreler[0]}-${widget.parametreler[1]}-${widget.parametreler[2]}-${_transactionsOgrenciSinif[i].id}";
      _addTransactionTemrinnot(
          key,
          i,
          widget.parametreler[2],
          _transactionsOgrenciSinif[i].id,
          int.parse(_controllers[i].text.isEmpty ? '0' : _controllers[i].text),
          'notlar');
    }
  }

  Future _addTransactionTemrinnot(String key, int id, int temrinId,
      int ogrenciId, int puan, String notlar) async {
    final transaction = TemrinnotModel(
        id: id,
        temrinId: temrinId,
        ogrenciId: ogrenciId,
        puan: puan,
        notlar: notlar,
        gelmedi: false);
    final box = TemrinnotBoxes.getTransactions();
    box.put(key, transaction);
  }

  void _buildTemrinNotListele() async {
    _transactionsTemrinnot =
        await TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
            .temrinnotFiltreListesiGetir(widget.parametreler[2]);
    for (var item in _transactionsTemrinnot) {
      print('id: ${item.id} ${item.ogrenciId} puan: ${item.puan} ${item.key}');
      // _puanlar[item.id] = item.puan;
    }
  }

  Future<void> _buildTemrinNotSil() async {
    final Box<TemrinnotModel> _box = TemrinnotBoxes.getTransactions();
    await _box.clear();
  }
}
