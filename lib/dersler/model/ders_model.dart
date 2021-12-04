//öğrenci adı-soyadı-no
import 'package:hive/hive.dart';

import 'package:flutter_application_hive/constants/hive_constans.dart';

part 'ders_model.g.dart';

@HiveType(typeId: HiveConstants.dersTypeId)
class DersModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String dersad;
  @HiveField(2)
  int sinifId;

  DersModel({
    required this.id,
    required this.dersad,
    required this.sinifId,
  });
}
