//öğrenci adı-soyadı-no
import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'ders_model.g.dart';

@HiveType(typeId: HiveConstants.dersTypeId)
class DersModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String dersad;

  DersModel({required this.id, required this.dersad});
}
