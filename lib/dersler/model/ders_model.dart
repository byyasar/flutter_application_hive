//öğrenci adı-soyadı-no
import 'package:hive/hive.dart';
part 'ders_model.g.dart';

@HiveType(typeId: 2)
class DersModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String dersad;

  DersModel({required this.id, required this.dersad});
}
