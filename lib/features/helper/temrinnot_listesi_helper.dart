import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';

class TemrinnotListesiHelper extends IListeHelper<TemrinnotModel> {
  TemrinnotListesiHelper(String key) : super(key);

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

  Future<List<TemrinnotModel>> fetcAlldata() async {
    List<TemrinnotModel> transactionsTemrinnot =
        TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
    return transactionsTemrinnot;
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

  @override
  List<TemrinnotModel>? getFilteredValues(String filtreKey, int filtreValue) {
    List<TemrinnotModel> transactionsTemrinnot = [];
    List<TemrinnotModel> transactionsTemrinnotGecici =
        TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();

    switch (filtreKey) {
      case "OgrenciId":
        for (var temrinnot in transactionsTemrinnotGecici) {
          if (temrinnot.ogrenciId == filtreValue) transactionsTemrinnot.add(temrinnot);
        }
        break;
      case "TemrinId":
        for (var temrinnot in transactionsTemrinnotGecici) {
          if (temrinnot.temrinId == filtreValue) transactionsTemrinnot.add(temrinnot);
        }
        break;
      default:
        return null;
    }

    return transactionsTemrinnot;
  }

  @override
  Future<void> addItem(dynamic model) async {
    Box<TemrinnotModel> _box = TemrinnotBoxes.getTransactions();
    await _box.add(model!);
  }

  @override
  Future<void> deleteItem(dynamic model) async {
    await model.delete();
  }

  @override
  Future<void> editItem(dynamic model) async {
    await model.save();
  }

  @override
  getItem(String key, Box? _box) {
    return _box?.get(key);
  }

  @override
  TemrinnotModel? getItemId(int id) {}
}
