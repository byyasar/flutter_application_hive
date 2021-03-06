import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/constants/icon_constans.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/widget/custom_menu_button.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_card.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
//import 'package:hive/hive.dart';
//import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TemrinNotViewPage extends StatefulWidget {
  List<int>? parametreler;

  TemrinNotViewPage({Key? key, required this.parametreler}) : super(key: key);

  @override
  _TemrinNotViewPageState createState() => _TemrinNotViewPageState();
}

class _TemrinNotViewPageState extends BaseState<TemrinNotViewPage> {
  List<TextEditingController> _puanControllers = [];
  List<OgrenciModel> _transactionsOgrenciSinif = [];
  List<TemrinnotModel> _transactionsTemrinnot = [];
  //List<TextEditingController> _aciklamaControllers = [];
  List<int> _puanlar = [];
  List<List<int>> _kriterler = [];

  @override
  initState() {
    super.initState();
    _buildSinifListesi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          //floatingActionButton: _buildFlaotingActionButton(),
          appBar: AppBar(title: const Text('TNS-Temrin Not Girişi'), centerTitle: true),
          body: Column(
            children: [
              /*   Text(
                  ' Sınıf:${widget.parametreler![0]} Ders :${widget.parametreler![1]} Temrin: ${widget.parametreler![2]}'), */

              Expanded(
                child: FutureBuilder(
                    future: TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
                        .temrinnotFiltreListesiGetir(widget.parametreler![2]),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return _buildOgrenciListesi(context, widget.parametreler![0]);
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

  _buildOgrenciListesi(BuildContext context, int filtreSinifId) {
    /* List<TemrinnotModel> _gelentemrinnotListesi = [];
    _gelentemrinnotListesi = temrinnotModelList; */

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: _transactionsOgrenciSinif.length,
      itemBuilder: (BuildContext context, int index) {
        _puanlar[index] = int.parse(
            _puanControllers[index].text.isEmpty || _puanControllers[index].text.toUpperCase() == 'G'
                ? '-1'
                : _puanControllers[index].text);
        // _aciklamaControllers[index].text = _bosKontrol(index, '_aciklamaControllers');

        final transaction = _transactionsOgrenciSinif[index];
        return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          puanController: _puanControllers[index],
          temrinId: widget.parametreler![2], parametreler: widget.parametreler,
          kriterler: _kriterler[index],

          //temrinnotModel: _gelentemrinnotListesi[index],
        );
      },
    );
  }

/*   String _bosKontrol(int index, String kontrollername) {
    switch (kontrollername) {
      case '_aciklamaControllers':
        return _aciklamaControllers[index].text.isEmpty ? '' : _aciklamaControllers[index].text;
      default:
        return '';
    }
  } */

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<void> _buildSinifListesi() async {
    _transactionsTemrinnot = await TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot)
        .temrinnotFiltreListesiGetir(widget.parametreler![2]);

    _puanControllers = [];
    // _aciklamaControllers = [];
    _puanlar = [];
    _kriterler = [];
    _transactionsOgrenciSinif =
        OgrenciListesiHelper(ApplicationConstants.boxOgrenci).getFilteredValues('SinifId', widget.parametreler![0])!;
    for (var i = 0; i < _transactionsOgrenciSinif.length; i++) {
      _puanControllers.add(TextEditingController());
      //_aciklamaControllers.add(TextEditingController());
      _puanlar.add(0);
      _kriterler.add([0, 0, 0, 0, 0]);
      _transactionsTemrinnot.map((item) {
        //print(_transactionsTemrinnot.indexOf(item));
        //print('Tid: ${item.temrinId} id: ${item.id} öğrenci id: ${item.ogrenciId} puan: ${item.puan} ${item.key}');
        if (item.ogrenciId == _transactionsOgrenciSinif[i].id) {
          _puanControllers[i].text = item.puan == -1 ? 'G' : item.puan.toString();
          //_aciklamaControllers[item.id].text = item.notlar;
          _kriterler[i] = item.kriterler;
        } else {}
      }).toList();

      
    }
  }
}
