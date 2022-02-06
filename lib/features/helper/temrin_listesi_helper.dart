import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/temrin/model/temrin_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TemrinListesiHelper extends IListeHelper<TemrinModel> {
  TemrinListesiHelper(String key) : super(key);

  @override
  List<TemrinModel>? getValues() {
    List<TemrinModel> transactionsTemrinListesi = TemrinBoxes.getTransactions().values.toList().cast<TemrinModel>();
    return transactionsTemrinListesi;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.temrinTypeId)) {
      Hive.registerAdapter(TemrinModelAdapter());
    }
  }

  @override
  TemrinModel? getItem(String key, Box<TemrinModel>? _box) {
    return _box?.get(key);
  }

  @override
  List<TemrinModel>? getFilteredValues(String filtreKey, int filtreValue) {
    List<TemrinModel> transactionsTemrinListesi = [];
    List<TemrinModel> transactionsTemrinListesiGecici =
        TemrinBoxes.getTransactions().values.toList().cast<TemrinModel>();

    for (var temrin in transactionsTemrinListesiGecici) {
      if (temrin.id == filtreValue) transactionsTemrinListesi.add(temrin);
    }
    return transactionsTemrinListesi;
  }

  @override
  Future<void> addItem(dynamic model) async {
    Box<TemrinModel> _box = TemrinBoxes.getTransactions();
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
  TemrinModel? getItemId(int id) {
    return null;
  
   
  }
}
