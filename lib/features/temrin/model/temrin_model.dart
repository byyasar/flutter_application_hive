import 'package:flutter_application_hive/constants/hive_constans.dart';
import 'package:hive/hive.dart';
part 'temrin_model.g.dart';

@HiveType(typeId: HiveConstants.temrinTypeId)
class TemrinModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String temrinKonusu;
  @HiveField(2)
  int dersId;
  TemrinModel(
      {required this.id, required this.temrinKonusu, required this.dersId});
}
