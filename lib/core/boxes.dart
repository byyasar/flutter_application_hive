import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/ders/model/ders_model.dart';
import 'package:flutter_application_hive/model/task_model.dart';
import 'package:flutter_application_hive/ogrenci/model/ogrenci_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<TaskModel> getTransactions() =>
      Hive.box<TaskModel>(ApplicationConstants.TASKBOX_NAME);
}

class OgrenciBoxes {
  static Box<OgrenciModel> getTransactions() =>
      Hive.box<OgrenciModel>(ApplicationConstants.BOX_OGRENCI);
}
class DersBoxes {
  static Box<DersModel> getTransactions() =>
      Hive.box<DersModel>(ApplicationConstants.BOX_DERS);
}
