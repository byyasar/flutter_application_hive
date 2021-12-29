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
  //deleteItem(T? model, Box<T>? box, int? silinecekId) async => await box!.delete(silinecekId);
  deleteItem(HiveObject? model) async => await model!.delete();
  Future addItem(T? model) async => await _box!.add(model!);
  void registerAdapters();
}
