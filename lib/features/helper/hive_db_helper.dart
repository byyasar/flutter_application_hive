import 'package:flutter_application_hive/constants/app_constants.dart';
import 'package:flutter_application_hive/features/helper/temrinnot_listesi_helper.dart';

void temrinNotSilOgrenciId(int silinecekOgrenciId) {
  TemrinnotListesiHelper(ApplicationConstants.boxTemrinNot).deleteItemsOgrenciId(silinecekOgrenciId);
}
