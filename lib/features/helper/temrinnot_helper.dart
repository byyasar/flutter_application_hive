import 'package:flutter_application_hive/core/boxes.dart';
import 'package:flutter_application_hive/features/temrinnot/model/temrinnot_model.dart';

class TemrinnotListesiHelper {
  Future<List<TemrinnotModel>> temrinnotTumListesiGetir() async {
    List<TemrinnotModel> transactionsTemrinnot =
        TemrinnotBoxes.getTransactions().values.toList().cast<TemrinnotModel>();
    return transactionsTemrinnot;
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
}
