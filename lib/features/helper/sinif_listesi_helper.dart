import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/helper/liste_helper_interface.dart';
import 'package:flutter_application_hive/features/siniflar/model/sinif_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SinifListesiHelper extends IListeHelper<SinifModel> {
  SinifListesiHelper(String key) : super(key);

  //Box<SinifModel>? _box;

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
}