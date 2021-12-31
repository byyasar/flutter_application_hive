import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  SinifModel? getItem(String key, Box<SinifModel>? _box) {
    return _box?.get(key);
  }

@override
  SinifModel? getItemId(int id) {
    List<SinifModel> transactionsSinifListesiGecici = SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    for (var sinif in transactionsSinifListesiGecici) {
      if (sinif.id == id) {
        return sinif;
      }
    }
  }

  @override
  List<SinifModel>? getFilteredValues(String filtreKey, int filtreValue) {
    List<SinifModel> transactionsSinifListesi = [];
    List<SinifModel> transactionsSinifListesiGecici = SinifBoxes.getTransactions().values.toList().cast<SinifModel>();

    for (var sinif in transactionsSinifListesiGecici) {
      if (sinif.id == filtreValue) transactionsSinifListesi.add(sinif);
    }
    return transactionsSinifListesi;
  }

  @override
  Future<void> addItem(dynamic model) async {
    Box<SinifModel> _box = SinifBoxes.getTransactions();
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
}
