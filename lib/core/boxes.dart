import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/dersler/model/ders_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:flutter_application_hive/siniflar/model/sinif_model.dart';
import 'package:flutter_application_hive/temrin/model/temrin_model.dart';
import 'package:flutter_application_hive/temrinnot/model/temrinnot_model.dart';
import 'package:hive/hive.dart';

class OgrenciBoxes {
  static Box<OgrenciModel> getTransactions() =>
      Hive.box<OgrenciModel>(ApplicationConstants.boxOgrenci);
}

class DersBoxes {
  static Box<DersModel> getTransactions() =>
      Hive.box<DersModel>(ApplicationConstants.boxDers);
}

class SinifBoxes {
  static Box<SinifModel> getTransactions() =>
      Hive.box<SinifModel>(ApplicationConstants.boxSinif);
}

class TemrinBoxes {
  static Box<TemrinModel> getTransactions() =>
      Hive.box<TemrinModel>(ApplicationConstants.boxTemrin);
}

class TemrinnotBoxes {
  static Box<TemrinnotModel> getTransactions() =>
      Hive.box<TemrinnotModel>(ApplicationConstants.boxTemrinNot);
}
