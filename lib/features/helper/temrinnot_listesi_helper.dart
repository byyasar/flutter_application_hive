import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class TemrinnotListesiHelper extends IListeHelper<TemrinnotModel> {
  TemrinnotListesiHelper(String key) : super(key);

  @override
  TemrinnotModel? getItem(String key, Box<TemrinnotModel>? box) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  Future<List<TemrinnotModel>> temrinnotFiltreListesiGetir(int filtreTemrinId) async {
    List<TemrinnotModel> transactionsFiltreTemrinnot = [];
    if (filtreTemrinId == -1) {
      List<TemrinnotModel> transactionsTemrinnot =
          TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
      return transactionsTemrinnot;
    } else {
      List<TemrinnotModel> transactionsTemrinnot =
          TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
      for (var model in transactionsTemrinnot) {
        if (model.temrinId == filtreTemrinId) {
          transactionsFiltreTemrinnot.add(model);
        }
      }
      return transactionsFiltreTemrinnot;
    }
  }

  @override
  List<TemrinnotModel>? getValues() {
    List<TemrinnotModel> transactionsTemrinnot =
        TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
    return transactionsTemrinnot;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.temrinNotTypeId)) {
      Hive.registerAdapter(TemrinnotModelAdapter());
    }
  }
}
