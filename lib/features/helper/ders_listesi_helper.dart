import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DersListesiHelper extends IListeHelper {
  DersListesiHelper(String key) : super(key);

  @override
  List<DersModel>? getValues() {
    List<DersModel> transactionsDersListesi = DersBoxes.getTransactions().values.toList().cast<DersModel>();
    return transactionsDersListesi;
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.dersTypeId)) {
      Hive.registerAdapter(DersModelAdapter());
    }
  }

  @override
  DersModel? getItemId(int id) {
    List<DersModel> transactionsDersListesiGecici = DersBoxes.getTransactions().values.toList().cast<DersModel>();
    for (var ders in transactionsDersListesiGecici) {
      if (ders.id == id) {
        return ders;
      } else {
        return null;
      }
    }
    return null;
  }

  @override
  List<DersModel>? getFilteredValues(String filtreKey, int filtreValue) {
    List<DersModel> transactionsDersListesi = [];
    List<DersModel> transactionsDersListesiGecici = DersBoxes.getTransactions().values.toList().cast<DersModel>();

    switch (filtreKey) {
      case "DersId":
        for (var ders in transactionsDersListesiGecici) {
          if (ders.id == filtreValue) transactionsDersListesi.add(ders);
        }
        break;
      case "SinifId":
        for (var ders in transactionsDersListesiGecici) {
          if (ders.sinifId == filtreValue) transactionsDersListesi.add(ders);
        }
        break;
      default:
        return null;
    }

    return transactionsDersListesi;
  }

  @override
  getItem(String key, Box? _box) {
    return _box?.get(key);
  }

  @override
  Future<void> addItem(dynamic model) async {
    Box<DersModel> _box = DersBoxes.getTransactions();
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
