import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'temrinnot_model.g.dart';

@HiveType(typeId: HiveConstants.temrinNotTypeId)
class TemrinnotModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int temrinId;
  @HiveField(2)
  int ogrenciId;
  @HiveField(3)
  int puan;
  @HiveField(4)
  String notlar;

  TemrinnotModel({
    required this.id,
    required this.temrinId,
    required this.ogrenciId,
    required this.puan,
    required this.notlar,
  });
}
