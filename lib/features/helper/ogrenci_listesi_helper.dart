import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/ogrenci/model/ogrenci_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OgrenciListesiHelper extends IListeHelper {
  OgrenciListesiHelper(String key) : super(key);

  @override
  List<OgrenciModel>? getValues() {
    List<OgrenciModel> transactionsOgrenciListesi = OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();
    return transactionsOgrenciListesi;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.ogrenciTypeId)) {
      Hive.registerAdapter(OgrenciModelAdapter());
    }
  }

  @override
  List<OgrenciModel>? getFilteredValues(String filtreKey, int filtreValue) {
    List<OgrenciModel> transactionsOgrenciListesi = [];
    List<OgrenciModel> transactionsOgrenciListesiGecici =
        OgrenciBoxes.getTransactions().values.toList().cast<OgrenciModel>();

    switch (filtreKey) {
      case "OgrenciId":
        for (var ogrenci in transactionsOgrenciListesiGecici) {
          if (ogrenci.id == filtreValue) transactionsOgrenciListesi.add(ogrenci);
        }
        break;
      case "SinifId":
        for (var ogrenci in transactionsOgrenciListesiGecici) {
          if (ogrenci.sinifId == filtreValue) transactionsOgrenciListesi.add(ogrenci);
        }
        break;
      default:
        return null;
    }

    return transactionsOgrenciListesi;
  }

  @override
  getItem(String key, Box? _box) {
    return _box?.get(key);
  }

  @override
  Future<void> addItem(dynamic model) async {
    Box<OgrenciModel> _box = OgrenciBoxes.getTransactions();
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
  getItemId(int id) {
   
  }
}
