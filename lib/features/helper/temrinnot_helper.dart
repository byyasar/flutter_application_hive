import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IListeHelper<T> {
  final String key;
  Box<T>? _box;
  IListeHelper(this.key);
  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox(key);
    }
  }

  void registerAdapters();
  List<T>? getValues();
  T? getItem(String key);
}

class SinifListesiHelper extends IListeHelper<SinifModel> {
  SinifListesiHelper(String key) : super(key);

  @override
  List<SinifModel>? getValues() {
    List<SinifModel> transactionsSinifListesi = SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    return transactionsSinifListesi;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.sinifTypeId)) {
      Hive.registerAdapter(SinifModelAdapter());
    }
  }

  @override
  SinifModel? getItem(String key) {
    return _box?.get(key);
  }
}

class TemrinnotListesiHelper extends IListeHelper<TemrinnotModel> {
  TemrinnotListesiHelper(String key) : super(key);

  @override
  TemrinnotModel? getItem(String key) {
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
