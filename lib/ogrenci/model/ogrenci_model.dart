//öğrenci adı-soyadı-no
import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'ogrenci_model.g.dart';

@HiveType(typeId: HiveConstants.ogrenciTypeId)
class OgrenciModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int nu;
  @HiveField(3)
  int sinifId;
  OgrenciModel(
      {required this.id,
      required this.name,
      required this.nu,
      required this.sinifId});
}
