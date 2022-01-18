import 'package:flutter/material.dart';
import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/widget/custom_ogrenci_card.dart';
import 'package:flutter_application_hive/features/helper/ogrenci_listesi_helper.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';

class TemrinNotViewPage extends StatefulWidget {
  List parametreler = [];

  TemrinNotViewPage({Key? key, required this.parametreler}) : super(key: key);

  @override
  _TemrinNotViewPageState createState() => _TemrinNotViewPageState();
}

class _TemrinNotViewPageState extends BaseState<TemrinNotViewPage> {
  List<TextEditingController> _controllers = [];
  List<OgrenciModel> transactionsOgrenciSinif = [];

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

  FloatingActionButton _buildFlaotingActionButton() {
    return FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          
        },
      );
  }

  _buildOgrenciListesi(BuildContext context, int filtreSinifId,
      List<TemrinnotModel> temrinnotModelList) {
    List filtretemrinList = [];
    filtretemrinList = temrinnotModelList;
    _controllers = [];
    transactionsOgrenciSinif =
        OgrenciListesiHelper(ApplicationConstants.boxOgrenci)
            .getFilteredValues('SinifId', widget.parametreler[0])!;

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: filtretemrinList.length,
      itemBuilder: (BuildContext context, int index) {
        _controllers.add(TextEditingController());
        final transaction = transactionsOgrenciSinif[index];
        return CustomOgrenciCard(
          transaction: transaction,
          index: index,
          controller: _controllers[index],
        );
      },
    );
  }
}
