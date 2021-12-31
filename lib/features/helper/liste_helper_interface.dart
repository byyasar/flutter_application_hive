import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IListeHelper<T> {
  final String key;
  Box<T>? _box;
  IListeHelper(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox(key);
    }
  }

  List<T>? getValues();
  T? getItem(String key, Box<T>? _box);
  List<T>? getFilteredValues(String filtreKey, int filtreValue);
  Future<void> deleteItem(HiveObject? model);
  Future<void> addItem(T? model);
  Future<void> editItem(HiveObject? model);
  T? getItemId(int id);
  void registerAdapters();
}
