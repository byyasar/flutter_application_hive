import 'package:hive/hive.dart';

abstract class IListeHelper<T> {
  final String key;
  Box<T>? _box;
  IListeHelper(
    this.key,
  );

  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox(key);
    }
  }

  void registerAdapters();
  List<T>? getValues();
  T? getItem(String key, Box<T>? _box);
  List<T>? getFilteredValues(String filtreKey, int filtreValue);
}
