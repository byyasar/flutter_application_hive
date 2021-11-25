//öğrenci adı-soyadı-no
import 'package:hive/hive.dart';
part 'ogrenci_model.g.dart';

@HiveType(typeId: 1)
class OgrenciModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int nu;

  OgrenciModel({required this.id, required this.name, required this.nu});
}
