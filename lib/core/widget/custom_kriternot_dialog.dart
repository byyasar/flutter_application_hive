import 'package:flutter/material.dart';
import 'package:flutter_application_hive/core/base/base_state.dart';
import 'package:flutter_application_hive/core/view/base_view.dart';
import 'package:flutter_application_hive/core/widget/cancel_button.dart';
import 'package:flutter_application_hive/core/widget/ok_button.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:flutter_application_hive/features/temrinnot/store/temrinnot_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomKriterDialog extends StatefulWidget {
  final TemrinnotModel? transaction;

  final Function(int id) onClickedDone;

  const CustomKriterDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _CustomKriterDialogState createState() => _CustomKriterDialogState();
}

class _CustomKriterDialogState extends BaseState<CustomKriterDialog> {
  final formKey = GlobalKey<FormState>();
  late TemrinnotStore viewModel;
  final _aciklamaController = TextEditingController();
  final _kriter1Controller = TextEditingController();
  final _kriter2Controller = TextEditingController();
  final _kriter3Controller = TextEditingController();
  final _kriter4Controller = TextEditingController();
  final _kriter5Controller = TextEditingController();
  final List<int> _kriterler = [0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    _kriter1Controller.text = _kriterler[0].toString();
    _kriter2Controller.text = _kriterler[1].toString();
    _kriter3Controller.text = _kriterler[2].toString();
    _kriter4Controller.text = _kriterler[3].toString();
    _kriter5Controller.text = _kriterler[4].toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TemrinnotStore>(
      viewModel: TemrinnotStore(),
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
                    return Text('TOPLAM =${viewModel.toplam}');
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
                        _kriterler[0] = int.tryParse(value.isEmpty ? '0' : value)!;
                        viewModel.setKriterler(_kriterler);
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
                        _kriterler[1] = int.tryParse(value.isEmpty ? '0' : value)!;
                        viewModel.setKriterler(_kriterler);
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
                        _kriterler[2] = int.tryParse(value.isEmpty ? '0' : value)!;
                        viewModel.setKriterler(_kriterler);
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
                        _kriterler[3] = int.tryParse(value.isEmpty ? '0' : value)!;
                        viewModel.setKriterler(_kriterler);
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
                        _kriterler[4] = int.tryParse(value.isEmpty ? '0' : value)!;
                        viewModel.setKriterler(_kriterler);
                      } else {
                        _kriter5Controller.text = '0';
                      }
                    },
                  ),

                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Açıklama', focusColor: Colors.blue),
                    controller: _aciklamaController,
                    onChanged: (value) {
                      viewModel.setAciklama(value);
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
        viewModel = model;
      },
    );
  }

  void buildOkButtononPressed() {
    print(viewModel);
    Navigator.of(context).pop(viewModel);
  }
}
