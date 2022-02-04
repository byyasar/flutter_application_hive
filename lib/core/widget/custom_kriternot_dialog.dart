import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_application_hive/features/temrinnot/store/temrinnot_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomKriterDialog extends StatefulWidget {
  final TemrinnotModel? transaction;
  final int? ogrenciId;
  //final int? temrinId;
  final List<int>? parametreler;
  final List<int>? kriterler;
  final Function(int id) onClickedDone;

  const CustomKriterDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
    required this.ogrenciId,
    required this.parametreler,
    required this.kriterler,
  }) : super(key: key);

  @override
  _CustomKriterDialogState createState() => _CustomKriterDialogState();
}

class _CustomKriterDialogState extends BaseState<CustomKriterDialog> {
  final formKey = GlobalKey<FormState>();
  //late TemrinnotStore viewModel;
  TemrinnotStore _viewModel = TemrinnotStore();

  final _aciklamaController = TextEditingController();
  final _kriter1Controller = TextEditingController();
  final _kriter2Controller = TextEditingController();
  final _kriter3Controller = TextEditingController();
  final _kriter4Controller = TextEditingController();
  final _kriter5Controller = TextEditingController();
  //final List<int> _kriterler = [0, 0, 0, 0, 0];
  int _toplam = 0;

  @override
  void initState() {
    super.initState();
    _kriter1Controller.text = widget.kriterler![0].toString();
    _kriter2Controller.text = widget.kriterler![1].toString();
    _kriter3Controller.text = widget.kriterler![2].toString();
    _kriter4Controller.text = widget.kriterler![3].toString();
    _kriter5Controller.text = widget.kriterler![4].toString();
    _toplam = int.tryParse(_kriter1Controller.text.isEmpty ? '0' : _kriter1Controller.text)! +
        int.tryParse(_kriter2Controller.text.isEmpty ? '0' : _kriter2Controller.text)! +
        int.tryParse(_kriter3Controller.text.isEmpty ? '0' : _kriter3Controller.text)! +
        int.tryParse(_kriter4Controller.text.isEmpty ? '0' : _kriter4Controller.text)! +
        int.tryParse(_kriter5Controller.text.isEmpty ? '0' : _kriter5Controller.text)!;
    //_viewModel.setToplam(_toplam);
    _viewModel.setKriterler(widget.kriterler!);
    //print('acışış $_toplam');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TemrinnotStore>(
      viewModel: _viewModel,
      onPageBuilder: (context, value) => AlertDialog(
        title: const Center(child: Text('Değerlendirme Kriterleri')),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: dyanmicWidth(.95),
              child: Column(
                children: <Widget>[
                  const Divider(height: 10),

                  Observer(builder: (_) {
                    _toplam = _viewModel.toplam;
                    return Text('TOPLAM =$_toplam');
                  }),
                  const Divider(height: 10),
                  //"buildTemrin(context, transactionsTemrin),
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                        labelText: '1-Bilgi -20P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                    controller: _kriter1Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                      if (puan >= 0 && puan <= 20) {
                        widget.kriterler![0] = int.tryParse(value.isEmpty ? '0' : value)!;
                        _viewModel.setKriterler(widget.kriterler!);
                      } else {
                        _kriter1Controller.text = '0';
                      }
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                        labelText: '2-Çözümü anlama ve aktarma -30P',
                        focusColor: Colors.blue,
                        labelStyle: TextStyle(fontSize: 18)),
                    controller: _kriter2Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                      if (puan >= 0 && puan <= 30) {
                        widget.kriterler![1] = int.tryParse(value.isEmpty ? '0' : value)!;
                        _viewModel.setKriterler(widget.kriterler!);
                      } else {
                        _kriter2Controller.text = '0';
                      }
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                        labelText: '3-Doğru şekilde uygulama ve çalıştırma -30P',
                        focusColor: Colors.blue,
                        labelStyle: TextStyle(fontSize: 18)),
                    controller: _kriter3Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                      if (puan >= 0 && puan <= 30) {
                        widget.kriterler![2] = int.tryParse(value.isEmpty ? '0' : value)!;
                        _viewModel.setKriterler(widget.kriterler!);
                      } else {
                        _kriter3Controller.text = '0';
                      }
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                        labelText: '4-Tasarım -10P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                    controller: _kriter4Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                      if (puan >= 0 && puan <= 10) {
                        widget.kriterler![3] = int.tryParse(value.isEmpty ? '0' : value)!;
                        _viewModel.setKriterler(widget.kriterler!);
                      } else {
                        _kriter4Controller.text = '0';
                      }
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                        labelText: '5-Süre -10P', focusColor: Colors.blue, labelStyle: TextStyle(fontSize: 18)),
                    controller: _kriter5Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int puan = int.tryParse(value.isEmpty ? '0' : value)!;
                      if (puan >= 0 && puan <= 10) {
                        widget.kriterler![4] = int.tryParse(value.isEmpty ? '0' : value)!;
                        _viewModel.setKriterler(widget.kriterler!);
                      } else {
                        _kriter5Controller.text = '0';
                      }
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Açıklama', focusColor: Colors.blue),
                    controller: _aciklamaController,
                    onChanged: (value) {
                      _viewModel.setAciklama(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCancelButton(context),
              const SizedBox(width: 10),
              buildOkButton(context, buildOkButtononPressed),
            ],
          ),
        ],
      ),
      onModelReady: (model) {
        _viewModel = model;
      },
    );
  }

  void buildOkButtononPressed() {
    print('model : $_viewModel ogrenciid:${widget.ogrenciId} temrin id: ${widget.parametreler![2]}');
    String key =
        "${widget.parametreler![0]}-${widget.parametreler![1]}-${widget.parametreler![2]}-${widget.ogrenciId!}";
    print('key $key');
    _addTransactionTemrinnot(key, 0, widget.parametreler![2], widget.ogrenciId!, _viewModel.toplam,
        _aciklamaController.text, _viewModel.kriterler);
    Navigator.of(context).pop(_viewModel);
  }

  Future _addTransactionTemrinnot(
      String key, int id, int temrinId, int ogrenciId, int puan, String notlar, List<int> kriterler) async {
    final transaction = TemrinnotModel(
        id: id,
        temrinId: temrinId,
        ogrenciId: ogrenciId,
        puan: puan,
        notlar: notlar,
        gelmedi: false,
        kriterler: kriterler);
    final box = TemrinnotBoxes.getTransactions();
    box.put(key, transaction);
  }
}
