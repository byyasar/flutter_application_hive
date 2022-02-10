//öğrenci adı-soyadı-no
import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'sinif_model.g.dart';

@HiveType(typeId: HiveConstants.sinifTypeId)
class SinifModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String sinifAd;

  SinifModel({required this.id, required this.sinifAd});

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sinifAd = json['sinifAd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sinifAd'] = sinifAd;
    return data;
  }
}
